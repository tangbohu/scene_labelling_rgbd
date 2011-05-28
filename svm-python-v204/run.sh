#!/bin/bash

#method=sum1.IP
lmethod=assoc
cmethod=sum1.IP
c=0.1
e=0.01
pid=(0 0 0 0)
for i in `seq 1 4`
do
#modelFile=`ls -lrt fold$i/imodels/model.c4.0.m* | cut -f 3 -d '/'| tail -1`

suffix=c$c.e$e.$lmethod
modelFile=model.$suffix

modelFolder=fold$i/models
#ls -lh fold$i/imodels/$modelFile
echo "out.$method.$modelFile" >> fold$i/lastout.txt
#mkdir fold$i/logs
#mkdir fold$i/models
#mkdir fold$i/imodels
#mkdir fold$i/pred
sh runsvm.sh $c $e $i $modelFile $modelFolder $suffix $cmethod &
p=$!
pid[$i]=$p
#sleep 60
done 
  
ps
echo ${pid[1]},${pid[2]},${pid[3]},${pid[4]} 
wait ${pid[1]}
wait ${pid[2]}
wait ${pid[3]}
wait ${pid[4]} 
echo "processes completed!"
perl ../get_avg_pr.pl out.$cmethod.$modelFile > avg_pr.$cmethod.$modelFile
method=$suffix.$cmethod
perl ../get_confusion_matrix.pl out.$cmethod.$modelFile $method  > confusionM.$method
 
