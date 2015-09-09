#!/bin/sh

MODELS="newsApp"

for MODEL in $MODELS; do
    mogenerator -m "$MODEL/$MODEL/$MODEL.xcdatamodeld/$MODEL.xcdatamodel" --machine-dir $MODEL/Model/Entities --human-dir $MODEL/Model --template-var arc=true
done
