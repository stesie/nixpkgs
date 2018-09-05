{ stdenv, buildPythonPackage, fetchPypi
, six
, wcwidth
}:

buildPythonPackage rec {
  pname = "prompt_toolkit";
  version = "1.0.15";

  src = fetchPypi {
    inherit pname version;
    sha256 = "05v9h5nydljwpj5nm8n804ms0glajwfy1zagrzqrg91wk3qqi1c5";
  };

  propagatedBuildInputs = [
    six
    wcwidth
  ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Library for building powerful interactive command lines in Python";
    homepage = https://github.com/jonathanslenders/python-prompt-toolkit;
    license = licenses.mit;
    maintainers = with maintainers; [ stesie ];
  };
}
