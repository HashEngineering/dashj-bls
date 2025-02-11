/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (https://www.swig.org).
 * Version 4.2.0
 *
 * Do not make changes to this file unless you know what you are doing - modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package org.dashj.bls;

public class ExtendedPublicKey {
  private transient long swigCPtr;
  protected transient boolean swigCMemOwn;

  protected ExtendedPublicKey(long cPtr, boolean cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = cPtr;
  }

  protected static long getCPtr(ExtendedPublicKey obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  protected static long swigRelease(ExtendedPublicKey obj) {
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
        DASHJBLSJNI.delete_ExtendedPublicKey(swigCPtr);
      }
      swigCPtr = 0;
    }
  }

  public static ExtendedPublicKey fromBytes(byte[] bytes, boolean fLegacy) {
    return new ExtendedPublicKey(DASHJBLSJNI.ExtendedPublicKey_fromBytes__SWIG_0(bytes, fLegacy), true);
  }

  public static ExtendedPublicKey fromBytes(byte[] bytes) {
    return new ExtendedPublicKey(DASHJBLSJNI.ExtendedPublicKey_fromBytes__SWIG_1(bytes), true);
  }

  public ExtendedPublicKey publicChild(long i, boolean fLegacy) {
    return new ExtendedPublicKey(DASHJBLSJNI.ExtendedPublicKey_publicChild__SWIG_0(swigCPtr, this, i, fLegacy), true);
  }

  public ExtendedPublicKey publicChild(long i) {
    return new ExtendedPublicKey(DASHJBLSJNI.ExtendedPublicKey_publicChild__SWIG_1(swigCPtr, this, i), true);
  }

  public long getVersion() {
    return DASHJBLSJNI.ExtendedPublicKey_getVersion(swigCPtr, this);
  }

  public short getDepth() {
    return DASHJBLSJNI.ExtendedPublicKey_getDepth(swigCPtr, this);
  }

  public long getParentFingerprint() {
    return DASHJBLSJNI.ExtendedPublicKey_getParentFingerprint(swigCPtr, this);
  }

  public long getChildNumber() {
    return DASHJBLSJNI.ExtendedPublicKey_getChildNumber(swigCPtr, this);
  }

  public ChainCode getChainCode() {
    return new ChainCode(DASHJBLSJNI.ExtendedPublicKey_getChainCode(swigCPtr, this), true);
  }

  public G1Element getPublicKey() {
    return new G1Element(DASHJBLSJNI.ExtendedPublicKey_getPublicKey(swigCPtr, this), true);
  }

  public void serialize(byte[] buffer, boolean fLegacy) {
    DASHJBLSJNI.ExtendedPublicKey_serialize__SWIG_0(swigCPtr, this, buffer, fLegacy);
  }

  public void serialize(byte[] buffer) {
    DASHJBLSJNI.ExtendedPublicKey_serialize__SWIG_1(swigCPtr, this, buffer);
  }

  public byte[] serialize(boolean fLegacy) { return DASHJBLSJNI.ExtendedPublicKey_serialize__SWIG_2(swigCPtr, this, fLegacy); }

  public byte[] serialize() { return DASHJBLSJNI.ExtendedPublicKey_serialize__SWIG_3(swigCPtr, this); }

  public ExtendedPublicKey() {
    this(DASHJBLSJNI.new_ExtendedPublicKey(), true);
  }

  public final static long REVISION = DASHJBLSJNI.ExtendedPublicKey_REVISION_get();
  public final static long SIZE = DASHJBLSJNI.ExtendedPublicKey_SIZE_get();
}
