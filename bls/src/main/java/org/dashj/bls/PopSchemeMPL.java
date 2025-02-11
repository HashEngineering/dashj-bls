/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (https://www.swig.org).
 * Version 4.2.0
 *
 * Do not make changes to this file unless you know what you are doing - modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package org.dashj.bls;

public class PopSchemeMPL extends CoreMPL {
  private transient long swigCPtr;

  protected PopSchemeMPL(long cPtr, boolean cMemoryOwn) {
    super(DASHJBLSJNI.PopSchemeMPL_SWIGUpcast(cPtr), cMemoryOwn);
    swigCPtr = cPtr;
  }

  protected static long getCPtr(PopSchemeMPL obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected static long swigRelease(PopSchemeMPL obj) {
    long ptr = 0;
    if (obj != null) {
      if (!obj.swigCMemOwn)
        throw new RuntimeException("Cannot release ownership as memory is not owned");
      ptr = obj.swigCPtr;
      obj.swigCMemOwn = false;
      obj.delete();
    }
    return ptr;
  }

  @SuppressWarnings({"deprecation", "removal"})
  protected void finalize() {
    delete();
  }

  public synchronized void delete() {
    if (swigCPtr != 0) {
      if (swigCMemOwn) {
        swigCMemOwn = false;
        DASHJBLSJNI.delete_PopSchemeMPL(swigCPtr);
      }
      swigCPtr = 0;
    }
    super.delete();
  }

  public static String getCIPHERSUITE_ID() {
    return DASHJBLSJNI.PopSchemeMPL_CIPHERSUITE_ID_get();
  }

  public static String getPOP_CIPHERSUITE_ID() {
    return DASHJBLSJNI.PopSchemeMPL_POP_CIPHERSUITE_ID_get();
  }

  public PopSchemeMPL() {
    this(DASHJBLSJNI.new_PopSchemeMPL(), true);
  }

  public G2Element popProve(PrivateKey seckey) {
    return new G2Element(DASHJBLSJNI.PopSchemeMPL_popProve(swigCPtr, this, PrivateKey.getCPtr(seckey), seckey), true);
  }

  public boolean popVerify(G1Element pubkey, G2Element signature_proof) {
    return DASHJBLSJNI.PopSchemeMPL_popVerify__SWIG_0(swigCPtr, this, G1Element.getCPtr(pubkey), pubkey, G2Element.getCPtr(signature_proof), signature_proof);
  }

  public boolean popVerify(byte[] pubkey, byte[] proof) {
    return DASHJBLSJNI.PopSchemeMPL_popVerify__SWIG_1(swigCPtr, this, pubkey, proof);
  }

  public boolean fastAggregateVerify(G1ElementVector pubkeys, byte[] message, G2Element signature) {
    return DASHJBLSJNI.PopSchemeMPL_fastAggregateVerify__SWIG_0(swigCPtr, this, G1ElementVector.getCPtr(pubkeys), pubkeys, message, G2Element.getCPtr(signature), signature);
  }

  public boolean fastAggregateVerify(Uint8VectorVector pubkeys, byte[] message, byte[] signature) {
    return DASHJBLSJNI.PopSchemeMPL_fastAggregateVerify__SWIG_1(swigCPtr, this, Uint8VectorVector.getCPtr(pubkeys), pubkeys, message, signature);
  }

}
