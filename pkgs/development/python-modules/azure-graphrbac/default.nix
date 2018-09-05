{ stdenv, buildPythonPackage, fetchPypi
, azure-common
, azure-nspkg
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-graphrbac";
  version = "0.40.0";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "1qlf916s4q8m1irx03imj7c4w2jmssjld34b5zz7hj3pryyrfjzr";
  };

  propagatedBuildInputs = [
    azure-common
    azure-nspkg
    msrestazure
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Microsoft Azure Graph RBAC Client Library for Python";
    homepage = https://github.com/Azure/azure-sdk-for-python;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
