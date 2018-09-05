{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-storage-common
, azure-storage-nspkg
}:

buildPythonPackage rec {
  pname = "azure-storage-blob";
  version = "1.1.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0rhwi4jwk261c7ljb1pzb4y9i2rbzhk1pznzifjrf3vdwchdrp2g";
  };

  propagatedBuildInputs = [
    azure-common
    azure-storage-common
    azure-storage-nspkg
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Storage Blob Client Library for Python";
    homepage = https://github.com/Azure/azure-storage-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
