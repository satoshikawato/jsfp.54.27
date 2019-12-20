
python writeoutgeneseq.py sp_list gene_list

for gene in l-rRNA s-rRNA
do
mafft \
--maxiterate 1000 --localpair \
--thread 63 \
${gene}.fasta >${gene}_nuc_aligned.fasta
done

for gene in COX3 CYTB ND4L ND4 ATP6 ND2 ND1 ND3 COX1 COX2 ND6 ND5 ; do

pgtranseq \
--table=9 \
${gene}.fasta ${gene}

mafft \
--maxiterate 1000 --localpair \
--thread 63 \
${gene}_aa.fasta >${gene}_aa_aligned.fasta

pgaligncodon \
--frame=1 \
--table=9 \
--alignment=${gene}_aa_aligned.fasta \
${gene}_nuc.fasta \
${gene}_nuc_aligned.fasta
python /home/genome/Desktop/Kawato/181023_bs/codonposition.py ${gene}_nuc_aligned.fasta
for n in 1 2 3; do
trimal \
-in ${gene}_nuc_aligned.fasta_P${n}.ffn \
-out ${gene}_nuc_aligned.fasta_P${n}_nogaps.ffn \
-nogaps
less ${gene}_nuc_aligned.fasta_P${n}_nogaps.ffn | cut -d ' ' -f 1 >nogaps/${gene}_nuc_aligned.fasta_P${n}_nogaps.ffn
done
done

trimal \
-in l-rRNA_nuc_aligned.fasta \
-out l-rRNA_nuc_aligned_nogaps.fasta \
-nogaps

trimal \
-in s-rRNA_nuc_aligned.fasta \
-out s-rRNA_nuc_aligned_nogaps.fasta \
-nogaps



raxmlHPC-PTHREADS-AVX -T 63 --no-seq-check --no-bfgs -n Bs_phylo -s whole.phy -f d -p 1234 -N 10 -m GTRGAMMA -q partition.file -M
raxmlHPC-PTHREADS-AVX -T 63 --no-seq-check --no-bfgs -n Bs_phylo_bootstrap -s whole.phy -f d -p 1234 -b 5678 -N 1000 -m GTRGAMMA -q partition.file -M
