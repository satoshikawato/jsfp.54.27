for num in 01 02 03 04 05 06 07 08 09 10 11
do
fastp \
--in1=Bs${num}_S${num}_L001_R1_001.fastq.gz \
--in2=Bs${num}_S${num}_L001_R2_001.fastq.gz \
--out1=Bs${num}_R1.fastq.gz \
--out2=Bs${num}_R2.fastq.gz  \
--length_required=140 \
--trim_tail1=4 \
--thread=8 --html=Bs${num}_fastp.html
done
