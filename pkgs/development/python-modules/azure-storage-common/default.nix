{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-storage-nspkg
, cryptography
, python-dateutil
, requests
}:

buildPythonPackage rec {
  pname = "azure-storage-common";
  version = "1.1.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1ks0h2vvswgknhxpwp9njy3q25r1mp3hl1fald6nrwcymnqa8rwc";
  };

  propagatedBuildInputs = [
    azure-common
    azure-storage-nspkg
    cryptography
    python-dateutil
    requests
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Storage Common Client Library for Python";
    homepage = https://github.com/Azure/azure-storage-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
