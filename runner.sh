for i in 1 2 4 8 32 64 128 512
#for i in 64 128 256 512 1024
do
   echo "Running for Batch Size $i"
   rm -rf out_fwd_only_$i
   mkdir -p out_fwd_only_$i
   tme=300

   if [ "$i" -le 32 ]; then
      tme=60
   elif [ "$i" -le 128 ]; then
      tme=120
   elif [ "$i" -le 512 ]; then
      tme=180
   elif [ "$i" -le 1024 ]; then
      tme=240
   fi
   
   echo "$i $tme"
   dlprof --mode=pytorch --output_path=out_fwd_only_$i --duration=$tme --iter_start=51 --iter_stop=60 --force=true poetry run yolo-train --data config/coco.data --model config/yolov3_$i.cfg  |& tee -a "out_fwd_only_$i/dump_fwd_only_$i.txt"
done

