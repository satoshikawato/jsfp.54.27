
bowtie2-build \
Bs${num}_pilon.fasta Bs${num}_pilon
for num in 01 02 03 04 05 06 07 08 09 10 11
do

bowtie2-build \
Bs${num}_pilon.fasta Bs${num}_pilon
bowtie2 \
-x Bs${num}_pilon \
-1 Bs${num}_R1.fastq.gz \
-2 Bs${num}_R2.fastq.gz \
--threads 63 2>Bs${num}_pilon_bowtie2.log \
|samtools sort -@ 63 -O BAM -o Bs${num}_pilon_sorted.bam -
samtools index Bs${num}_pilon_sorted.bam


java -Xmx110G -jar pilon.jar \
--genome Bs${num}_pilon.fasta \
--frags Bs${num}_pilon_sorted.bam \
--output Bs${num}_pilon2 \
--outdir Bs${num}_pilon2 \
--minmq 5 \
--minqual 5 \
--threads 63 \
--fix all,amb
