{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-mgmt-nspkg
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-mgmt-batch";
  version = "4.1.0";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "0nfkvh54bmjf7hn08dz3hixrkmn1yfv84spf2rrxi54avh3z8s9f";
  };

  propagatedBuildInputs = [ azure-common azure-mgmt-nspkg msrestazure ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Batch Management Client Library for Python";
    homepage = https://github.com/Azure/azure-sdk-for-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
