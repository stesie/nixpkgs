{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-mgmt-nspkg
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-mgmt-storage";
  version = "2.0.0rc4";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "1lybk7pqgx126a375ylx99gpif2hik3djx028ffdp6223c0q4hkz";
  };

  propagatedBuildInputs = [
    azure-common
    azure-mgmt-nspkg
    msrestazure
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Storage Management Client Library for Python";
    homepage = https://github.com/Azure/azure-sdk-for-python;
    license = licenses.mit;
    maintainers = with maintainers; [ olcai stesie ];
  };
}
