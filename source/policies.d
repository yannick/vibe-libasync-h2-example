module policies;

import memutils.vector;
import botan.tls.policy;

class FasterTLSPolicy : TLSPolicy
{
public:

    /**
    * Returns a list of ciphers we are willing to negotiate, in
    * order of preference.
    */
    override Vector!string allowedCiphers() const
    {
        return Vector!string(["AES-128/CCM", "AES-256/GCM", "AES-128/GCM", "AES-256/CCM",]);
    }

    /**
    * Returns a list of hash algorithms we are willing to use for
    * signatures, in order of preference.
    */
    override Vector!string allowedSignatureHashes() const
    {
        return Vector!string(["SHA-256", "SHA-512", "SHA-384", "SHA-224",]);
    }

    /**
    * Returns a list of MAC algorithms we are willing to use.
    */
    override Vector!string allowedMacs() const
    {
        return Vector!string(["SHA-256", "SHA-384", "AEAD",]);
    }

    /**
    * Returns a list of key exchange algorithms we are willing to
    * use, in order of preference. Allowed values: DH, empty string
    * (representing RSA using server certificate key)
    */
    override Vector!string allowedKeyExchangeMethods() const
    {
        return Vector!string([//"SRP_SHA",
                //"ECDHE_PSK",
                //"DHE_PSK",
                //"PSK",
                "RSA", "ECDH", "DH",]);
    }

    /**
    * Returns a list of signature algorithms we are willing to
    * use, in order of preference. Allowed values RSA and DSA.
    */
    override Vector!string allowedSignatureMethods() const
    {
        return Vector!string(["RSA", "ECDSA", "DSA",//""
        ]);
    }

}
