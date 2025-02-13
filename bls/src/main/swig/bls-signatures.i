%module DASHJBLS
%{
#include "bls-signatures/include/dashbls/bls.hpp"
#include "bls-signatures/include/dashbls/chaincode.hpp"
#include "bls-signatures/include/dashbls/elements.hpp"
#include "bls-signatures/include/dashbls/extendedprivatekey.hpp"
#include "bls-signatures/include/dashbls/extendedpublickey.hpp"
#include "bls-signatures/include/dashbls/hdkeys.hpp"
#include "bls-signatures/include/dashbls/hkdf.hpp"
#include "bls-signatures/include/dashbls/privatekey.hpp"
#include "bls-signatures/include/dashbls/schemes.hpp"
#include "bls-signatures/include/dashbls/threshold.hpp"
#include "bls-signatures/include/dashbls/util.hpp"
#include "threshold-v1.hpp"
using namespace bls;
%}

%include "std_vector.i"
%include "std_string.i"
%include "bytes.i"
typedef unsigned char uint8_t;
typedef unsigned int uint32_t;
typedef long size_t;
namespace std {
  %template(Uint8Vector) vector<uint8_t>;
  %template(Uint8VectorVector) vector<vector<uint8_t>>;
  %template(PrivateKeyVector) vector<bls::PrivateKey>;
  %template(G1ElementVector) vector<bls::G1Element>;
  %template(G2ElementVector) vector<bls::G2Element>;
}

namespace bls {
  %copyctor G1Element;
  %copyctor G2Element;
  %ignore BLS::SetSecureAllocator;
  %ignore G1Element::FromNative;
  %ignore G1Element::ToNative;
  %ignore G2Element::FromNative;
  %ignore G2Element::ToNative;
  %ignore GTElement::FromNative;
  %ignore GTElement::ToNative;
  %ignore PrivateKey::PrivateKey(PrivateKey &&k);
  %ignore Util;

  %rename("%(lowercamelcase)s", %$isfunction) "";
  %rename ("$ignore", fullname=1) CoreMPL::Aggregate(const vector<Bytes>& signatures);
  %rename ("$ignore", fullname=1) CoreMPL::AggregateVerify(const vector<Bytes>& pubkeys, const vector<Bytes>& messages, const Bytes& signature) override;
  %rename ("$ignore", fullname=1) CoreMPL::AggregateVerify(const vector<G1Element>& pubkeys, const vector<Bytes>& messages, const G2Element& signature) override;
  %rename ("$ignore", fullname=1) AugSchemeMPL::Verify(const G1Element& pubkey, const Bytes& message, const G2Element& signature) override;
  %rename ("$ignore", fullname=1) AugSchemeMPL::AggregateVerify(const vector<Bytes>& pubkeys, const vector<Bytes>& messages, const Bytes& signature) override;
  %rename ("$ignore", fullname=1) AugSchemeMPL::AggregateVerify(const vector<G1Element>& pubkeys, const vector<Bytes>& messages, const G2Element& signature) override;
  %rename ("$ignore", fullname=1) BasicSchemeMPL::Verify(const G1Element& pubkey, const Bytes& message, const G2Element& signature) override;
  %rename ("$ignore", fullname=1) BasicSchemeMPL::AggregateVerify(const vector<Bytes>& pubkeys, const vector<Bytes>& messages, const Bytes& signature) override;
  %rename ("$ignore", fullname=1) BasicSchemeMPL::AggregateVerify(const vector<G1Element>& pubkeys, const vector<Bytes>& messages, const G2Element& signature) override;
  %rename ("$ignore", fullname=1) LegacySchemeMPL::Verify(const G1Element& pubkey, const Bytes& message, const G2Element& signature) override;
  %rename ("$ignore", fullname=1) LegacySchemeMPL::AggregateVerify(const vector<Bytes>& pubkeys, const vector<Bytes>& messages, const Bytes& signature) override;
  %rename ("$ignore", fullname=1) LegacySchemeMPL::AggregateVerify(const vector<G1Element>& pubkeys, const vector<Bytes>& messages, const G2Element& signature) override;
  %rename ("$ignore", fullname=1) PopSchemeMPL::FastAggregateVerify(const vector<Bytes>& pubkeys, const Bytes& message, const Bytes& signature);

  %ignore PrivateKey::SerializeToArray(bool fLegacy) const;
  %ignore PrivateKey::SerializeToArray() const;
  %ignore G1Element::SerializeToArray(bool fLegacy) const;
  %ignore G1Element::SerializeToArray() const;
  %ignore G2Element::SerializeToArray(bool fLegacy) const;
  %ignore G2Element::SerializeToArray() const;
  %ignore GTElement::SerializeToArray() const;
  %ignore Threshold::PrivateKeyRecover(const std::vector<PrivateKey>& sks, const std::vector<Bytes>& ids);
  %ignore Threshold::PublicKeyRecover(const std::vector<G1Element>& sks, const std::vector<Bytes>& ids);
  %ignore Threshold::SignatureRecover(const std::vector<G2Element>& sigs, const std::vector<Bytes>& ids);

  %rename ("$ignore", fullname=1) LegacySchemeMPL::AggregateVerify(const vector<G1Element> &pubkeys,
                                                           const vector<vector<uint8_t>> &messages,
                                                           const G2Element &signature) final ;
  %rename ("$ignore", fullname=1) LegacySchemeMPL::AggregateVerify(const vector<vector<uint8_t>> &pubkeys,
                                                                                    const vector<vector<uint8_t>> &messages,
                                                                                    const vector<uint8_t> &signature) final;
  %extend LegacySchemeMPL {
    bool aggregateVerify(const vector<G1Element> &pubkeys,
                           const vector<vector<uint8_t>> &messages,
                           const G2Element &signature) final {
        std::vector<bls::Bytes> messagesVec;
        messagesVec.reserve(messages.size());
        for (size_t i = 0; i < messages.size(); i++) {
            messagesVec.emplace_back(messages[i]);
        }
        return self->AggregateVerify(pubkeys, messagesVec, signature);
    }

  }

  %extend BLS {
    static const long RLC_OK = 0;
    static long getContextError() {
        return core_get()->code;
    }
    static void setContextError(long error) {
        core_get()->code = error;
    }
    static long getContext() {
        return (long)core_get();
    }
  }
  %nspace Threshold;
}

// equality operators
%rename (objectEquals) operator==(ChainCode const &a, ChainCode const &b);
%rename (objectEquals) operator==(ExtendedPrivateKey const &a, ExtendedPrivateKey const &b);
%rename (objectEquals) operator==(ExtendedPublicKey const &a, ExtendedPublicKey const &b);
%rename (objectEquals) operator==(PrivateKey const &a, PrivateKey const &b);
%rename (objectEquals) operator==(PublicKey const &a, PublicKey const &b);
%rename (objectEquals) operator==(G1Element const &a, G1Element const &b);
%rename (objectEquals) operator==(G2Element const &a, G2Element const &b);
%rename (objectEquals) operator==(GTElement const &a, GTElement const &b);

// addition operators
%rename (add) operator+(const G1Element& a, const G1Element& b);
%rename (add) operator+(const G2Element& a, const G2Element& b);

// multiply operators
%rename (multiply) operator*(const G1Element& a, const G1Element& b);
%rename (multiply) operator*(const G2Element& a, const G2Element& b);
%rename (multiply) operator*(const G1Element& a, const PrivateKey& b);
%rename (multiply) operator*(const PrivateKey& a, const G1Element& b);
%rename (multiply) operator*(const G2Element& a, const PrivateKey& b);
%rename (multiply) operator*(const PrivateKey& a, const G2Element& b);
%rename (multiply) operator*(GTElement &a, GTElement &b);

// bitwise operators
%rename (andOperator) operator&(const G1Element &a, const G2Element &b);

// ignore these operators
%ignore operator<<;
%ignore operator=;
%ignore operator!=;
%ignore operator*=;
%ignore operator+=;
%ignore operator*(const G1Element &a, const bn_t &k);
%ignore operator*(const bn_t &k, const G1Element &a);
%ignore operator*(const G2Element &a, const bn_t &k);
%ignore operator*(const bn_t &k, const G2Element &a);
%ignore operator*(const PrivateKey& a, const bn_t& k);
%ignore operator*(const bn_t& k, const PrivateKey& a);

// unsigned char [] to byte []
%typemap(jni) (unsigned char *) "jbyteArray"
%typemap(jtype) (unsigned char *) "byte[]"
%typemap(jstype) (unsigned char *) "byte[]"
%typemap(in) (unsigned char *) {
  $1 = (unsigned char *) JCALL2(GetByteArrayElements, jenv, $input, 0);
}

%typemap(argout) (unsigned char *) {
  JCALL3(ReleaseByteArrayElements, jenv, $input, (jbyte *) $1, 0);
}

%typemap(javain) (unsigned char *) "$javainput"

%typemap(freearg) (unsigned char *) ""


// vector<uint8_t> to byte[]
%typemap(jni) std::vector<uint8_t> "jbyteArray"
%typemap(jtype) std::vector<uint8_t> "byte[]"
%typemap(jstype) std::vector<uint8_t> "byte[]"
%typemap(javain) std::vector<uint8_t> "$javainput"
%typemap(javaout) std::vector<uint8_t> { return $jnicall; }

%typemap(in) std::vector<uint8_t> (std::vector<uint8_t> vec) {
  if (!$input) {
    SWIG_JavaThrowException(jenv, SWIG_JavaNullPointerException, "null array");
    return $null;
  }
  const jsize sz = jenv->GetArrayLength($input);
  jbyte* const jarr = jenv->GetByteArrayElements($input, 0);
  if (!jarr) return $null;
  vec.assign(jarr, jarr+sz);
  jenv->ReleaseByteArrayElements($input, jarr, JNI_ABORT);
  $1 = &vec;
}

%typemap(out) std::vector<uint8_t> {
  const jsize sz = $1.size();
  $result = jenv->NewByteArray(sz);
  jenv->SetByteArrayRegion($result, 0, sz, reinterpret_cast<jbyte *>($1.data()));
}

%apply std::vector<uint8_t> { const std::vector<uint8_t> & };

// ignore functions with vector<uint8_t>
namespace bls {
    %ignore PrivateKey::FromByteVector;
    %ignore G1Element::FromByteVector;
    %ignore G2Element::FromByteVector;
    %ignore GTElement::FromByteVector;
    %ignore G1Element::FromMessage(const std::vector<uint8_t>& message, const uint8_t* dst, int dst_len, bool fLegacy = false);
    %ignore G2Element::FromMessage(const std::vector<uint8_t>& message, const uint8_t* dst, int dst_len, bool fLegacy = false);
    %ignore HDKeys::KeyGen(const std::vector<uint8_t>& seed);
    %ignore CoreMPL::KeyGen(const vector<uint8_t>& seed);
    %ignore CoreMPL::Sign(const PrivateKey &seckey, const vector<uint8_t> &message);
    %ignore CoreMPL::Verify(const G1Element &pubkey, const vector<uint8_t> &message, const G2Element &signature);
    %ignore CoreMPL::Verify(const vector<uint8_t> &pubkey, const vector<uint8_t> &message, const vector<uint8_t> &signature);
    %ignore PopSchemeMPL::PopVerify(const vector<uint8_t> &pubkey, const vector<uint8_t> &proof);
    %ignore PopSchemeMPL::FastAggregateVerify(const vector<G1Element> &pubkeys, const vector<uint8_t> &message, const G2Element &signature);
    %ignore AugSchemeMPL::Sign(const PrivateKey &seckey, const vector<uint8_t> &message, const G1Element &prepend_pk);
}

// Language independent exception handler
%include exception.i

%exception {
	try {
		$function
	} catch(std::string x) {
	    SWIG_exception(SWIG_ValueError, x.c_str());
	} catch(std::runtime_error x) {
        SWIG_exception(SWIG_RuntimeError, x.what());
    } catch(std::invalid_argument x) {
        SWIG_exception(SWIG_ValueError, x.what());
    } catch(std::length_error x) {
        SWIG_exception(SWIG_ValueError, x.what());
    } catch(std::logic_error x) {
        SWIG_exception(SWIG_ValueError, x.what());
    } catch(std::exception x) {
        SWIG_exception(SWIG_SystemError, x.what());
    } catch(...) {
		SWIG_exception(SWIG_RuntimeError,"Unknown exception");
	}
}

%include "src/main/cpp/bls-signatures/include/dashbls/bls.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/chaincode.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/elements.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/privatekey.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/extendedpublickey.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/extendedprivatekey.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/hdkeys.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/hkdf.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/schemes.hpp"
%include "src/main/cpp/bls-signatures/include/dashbls/threshold.hpp"
%include "src/main/cpp/threshold-v1.hpp"


