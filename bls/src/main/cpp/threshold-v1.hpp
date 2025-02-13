#ifndef DASHJ_BLS_THRESHOLD_HPP
#define DASHJ_BLS_THRESHOLD_HPP

#include "bls-signatures/include/dashbls/threshold.hpp"
#include <stdint.h>

using namespace std;
namespace bls {

    namespace Threshold {

        PrivateKey PrivateKeyRecover(const std::vector<PrivateKey>& sks, const std::vector<vector<uint8_t>>& ids);

        G1Element PublicKeyRecover(const std::vector<G1Element>& sks, const std::vector<vector<uint8_t>>& ids);

        G2Element SignatureRecover(const std::vector<G2Element>& sigs, const std::vector<vector<uint8_t>>& ids);

    } // end namespace Threshold
} // end namespace bls

#endif