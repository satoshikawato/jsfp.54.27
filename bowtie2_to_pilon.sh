cd /home/genome/Desktop/Kawato/181011_kwt/bowtie2/
/home/genome/kawato/bowtie2/bowtie2-2.3.4.1-linux-x86_64/bowtie2-build \
Bs${num}_pilon.fasta Bs${num}_pilon
for num in 01 02 03 04 05 06 07 08 09 10 11
do

/home/genome/kawato/bowtie2/bowtie2-2.3.4.1-linux-x86_64/bowtie2-build \
Bs${num}_pilon.fasta Bs${num}_pilon
/home/genome/kawato/bowtie2/bowtie2-2.3.4.1-linux-x86_64/bowtie2 \
-x Bs${num}_pilon \
-1 Bs${num}_R1.fastq.gz \
-2 Bs${num}_R2.fastq.gz \
--threads 63 2>Bs${num}_pilon_bowtie2.log \
|samtools sort -@ 63 -O BAM -o Bs${num}_pilon_sorted.bam -
samtools index Bs${num}_pilon_sorted.bam


java -Xmx110G -jar /home/genome/kawato/pilon-1.22.jar \
--genome Bs${num}_pilon.fasta \
--frags Bs${num}_pilon_sorted.bam \
--output Bs${num}_pilon2 \
--outdir Bs${num}_pilon2 \
--minmq 5 \
--minqual 5 \
--threads 63 \
--fix all,amb
