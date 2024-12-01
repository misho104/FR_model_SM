#!/bin/bash

: ${MATH:=WolframKernel}

: ${FR_DIR:="$PWD/FeynRules"}
: ${FR_FILE:="SM.fr"}

INIT="
  SetDirectory[\"$PWD\"];
  \$FeynRulesPath=\"$FR_DIR\";
  \$Path = AppendTo[\$Path, \$FeynRulesPath] // DeleteDuplicates;
  FR\$Parallel = False;
  <<FeynRules\`;
  LoadModel[\"$FR_FILE\"];
"

# Feynman Gauge
$MATH <<_EOC_
$INIT
FeynmanGauge = True;
WriteUFO[LSM, Exclude4Scalars->False];
_EOC_

$MATH <<_EOC_
$INIT
FeynmanGauge = True;
WriteFeynArtsOutput[LSM, Exclude4Scalars->False];
_EOC_

# Unitarity Gauge
$MATH <<_EOC_
$INIT
FeynmanGauge = False;
M\$ModelName = "Standard Model Unitarity";
WriteUFO[LSM, Exclude4Scalars->False];
_EOC_

$MATH <<_EOC_
$INIT
FeynmanGauge = False;
M\$ModelName = "Standard Model Unitarity";
WriteFeynArtsOutput[LSM, Exclude4Scalars->False];
_EOC_
