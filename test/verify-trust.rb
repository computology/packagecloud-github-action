# frozen_string_literal: true

require "openssl"

store = OpenSSL::X509::Store.new
store.set_default_paths
store.purpose = OpenSSL::X509::PURPOSE_SSL_SERVER

# Keep the published probe certificates within their validity period so that
# expiration cannot hide a regression that restores trust in their issuers.
store.time = Time.utc(2026, 10, 21)

# Public probe chains from https://emudhra.we-have-a-problem.com/chains.zip,
# captured on October 20, 2026. Cover both the emSign and Sectigo trust paths.
%w[emudhra.pem emudhra-aaa.pem].each do |filename|
  path = File.join(__dir__, "fixtures", filename)
  chain = File.read(path).scan(/-----BEGIN CERTIFICATE-----.*?-----END CERTIFICATE-----/m).map do |pem|
    OpenSSL::X509::Certificate.new(pem)
  end

  accepted = store.verify(chain.first, chain.drop(1))
  unless !accepted && store.error == OpenSSL::X509::V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY
    abort "FAIL: #{File.basename(path)}: accepted=#{accepted}, #{store.error_string}"
  end
  puts "PASS: #{File.basename(path)} rejected because its issuer is untrusted"
end

# A missing or empty trust store must not make the rejection checks pass.
amazon_root = OpenSSL::X509::Certificate.new(
  File.read("/usr/share/ca-certificates/mozilla/Amazon_Root_CA_1.crt")
)
abort "FAIL: Amazon Root CA 1 is no longer trusted" unless store.verify(amazon_root)
puts "PASS: Amazon Root CA 1 remains trusted"
