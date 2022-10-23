package org.dashj.bls;

import org.dashj.bls.Utils.Util;
import org.junit.Test;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;

public class LegacyHDKeysTest extends BaseTest {
    @Test
    public void shouldCreateAnExtendedPrivateKeyFromSeed() {
        byte[] seed = new byte[]{1, 50, 6, (byte) 244, 24, (byte) 199, 1, 25};
        ExtendedPrivateKey esk = ExtendedPrivateKey.fromSeed(seed);

        ExtendedPrivateKey esk77 = esk.privateChild(77 + (1L << 31));
        ExtendedPrivateKey esk77copy = esk.privateChild(77 + (1L << 31));

        assertObjectEquals(esk77, esk77copy);

        ExtendedPrivateKey esk77nh = esk.privateChild(77);

        ExtendedPrivateKey eskLong = esk.privateChild((1L << 31) + 5)
                .privateChild(0)
                .privateChild(0)
                .privateChild((1L << 31) + 56)
                .privateChild(70)
                .privateChild(4);
        byte[] chainCode = new byte[32];
        eskLong.getChainCode().serialize(chainCode);
    }


    @Test
    public void shouldMatchDerivationThroughPrivateAndPublicKeys() {
        byte[] seed = new byte[]{1, 50, 6, (byte) 244, 24, (byte) 199, 1, 25};
        ExtendedPrivateKey esk = ExtendedPrivateKey.fromSeed(seed);
        ExtendedPublicKey epk = esk.getExtendedPublicKey();

        G1Element pk1 = esk.privateChild(238757).getPublicKey();
        G1Element pk2 = epk.publicChild(238757).getPublicKey();

        assertObjectEquals(pk1, pk2);

        PrivateKey sk3 = esk.privateChild(0)
                .privateChild(3)
                .privateChild(8)
                .privateChild(1)
                .getPrivateKey();

        G1Element pk4 = epk.publicChild(0)
                .publicChild(3)
                .publicChild(8)
                .publicChild(1)
                .getPublicKey();
        assertObjectEquals(sk3.getG1Element(), pk4);

        G2Element sig = new LegacySchemeMPL().sign(sk3, seed);

        System.out.println("sig: " + Util.hexStr(sig.serialize()));
        System.out.println("pk4: " + Util.hexStr(pk4.serialize()));
        System.out.println("sk3: " + Util.hexStr(sk3.serialize()));
        System.out.println("seed: " + Util.hexStr(seed));
        //TODO: determine why this fails
        //assertTrue(new LegacySchemeMPL().verify(sk3.getG1Element(), seed, sig));

        G2Element sigB = new BasicSchemeMPL().sign(sk3, seed);
        assertTrue(new BasicSchemeMPL().verify(sk3.getG1Element(), seed, sigB));
    }

    @Test
    public void shouldPreventHardenedPkDerivation() {
        byte[] seed = new byte[]{1, 50, 6, (byte) 244, 24, (byte) 199, 1, 25};
        ExtendedPrivateKey esk = ExtendedPrivateKey.fromSeed(seed);
        ExtendedPublicKey epk = esk.getExtendedPublicKey();

        ExtendedPrivateKey sk = esk.privateChild((1L << 31) + 3);
        assertThrows(Exception.class, () -> epk.publicChild((1L << 31) + 3));
    }

    @Test
    public void shouldDerivePublicChildFromParent() {
        byte[] seed = new byte[]{1, 50, 6, (byte) 244, 24, (byte) 199, 1, 0, 0, 0};
        ExtendedPrivateKey esk = ExtendedPrivateKey.fromSeed(seed);
        ExtendedPublicKey epk = esk.getExtendedPublicKey();

        ExtendedPublicKey pk1 = esk.publicChild(13);
        ExtendedPublicKey pk2 = epk.publicChild(13);

        assertObjectEquals(pk1, pk2);
    }

    @Test
    public void shouldOutputStructures() {
        byte[] seed = new byte[]{1, 50, 6, (byte) 244, 24, (byte) 199, 1, 0, 0, 0};
        ExtendedPrivateKey esk = ExtendedPrivateKey.fromSeed(seed);
        ExtendedPublicKey epk = esk.getExtendedPublicKey();

        System.out.println("epk:    " + Util.hexStr(epk.serialize()));
        System.out.println("epk pub:" + Util.hexStr(epk.getPublicKey().serialize()));
        System.out.println("epk cc: " + Util.hexStr(epk.getChainCode().serialize()));

        G2Element sig1 = new LegacySchemeMPL().sign(esk.getPrivateKey(), seed);
        System.out.println("sig1:" + Util.hexStr(sig1.serialize()));
        // TODO: why does this fail?
        //assertTrue(new LegacySchemeMPL().verify(epk.getPublicKey(), seed, sig1));
    }

    @Test
    public void shouldSerializeExtendedKeys() {
        byte[] seed = new byte[]{1, 50, 6, (byte) 244, 25, (byte) 199, 1, 25};
        ExtendedPrivateKey esk = ExtendedPrivateKey.fromSeed(seed);
        ExtendedPublicKey epk = esk.getExtendedPublicKey();

        G1Element pk1 = esk.privateChild(238757).getPublicKey();
        G1Element pk2 = epk.publicChild(238757).getPublicKey();

        assertObjectEquals(pk1, pk2);

        ExtendedPrivateKey sk3 = esk.privateChild(0)
                .privateChild(3)
                .privateChild(8)
                .privateChild(1);

        ExtendedPublicKey pk4 = epk.publicChild(0)
                .publicChild(3)
                .publicChild(8)
                .publicChild(1);
        byte[] buffer1 = new byte[(int) ExtendedPrivateKey.SIZE];
        byte[] buffer2 = new byte[(int) ExtendedPublicKey.SIZE];
        byte[] buffer3 = new byte[(int) ExtendedPublicKey.SIZE];

        sk3.serialize(buffer1);
        sk3.getExtendedPublicKey().serialize(buffer2, true);
        pk4.serialize(buffer3, true);
        assertArrayEquals(buffer2, buffer3);
        //REQUIRE(std.memcmp(buffer2, buffer3, ExtendedPublicKey.SIZE) == 0);
    }
}
