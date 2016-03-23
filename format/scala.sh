#! /bin/bash

scalariform -q  +alignParameters +alignSingleLineCaseStatements +compactControlReadability +compactStringConcatenation +doubleIndentClassDeclaration "$@" 
