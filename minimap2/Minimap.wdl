##############################################################################################
# run workflow:
#   dockstore workflow launch --local-entry Minimap.wdl --json minimap.json
###############################################################################################
#set wdl version
version 1.0

#add and name a workflow block
workflow minimapWorkflow {
   call minimap
   call samtools{
      input:
        alignment = minimap.sam_alignment
   }
   output {
   File sorted_bam = samtools.sorted_bam
   File bam_index = samtools.bam_index
   }
}
#define the 'minimap' task
task minimap {
  input {
    File reads
    File assembly
    String docker_image
    Int max_threads
    Int RAM
    Int threadCount
  }
  String sam_alignment = basename(reads,".fasta") + ".sam"
  #define command to execute when this task runs
  command {
    minimap2 -a -x map-ont -t \
    ${max_threads} \
    ${assembly} \
    ${reads} > ${sam_alignment}
  }
  #specify the output(s) of this task so cromwell will keep track of them
  output {
    File sam_alignment = "${sam_alignment}"
  }
  runtime {
    docker: docker_image
    memory: RAM + "GB"
    cpus: threadCount
  }
}

#define the 'samtools' task
task samtools {
  input {
    File alignment
    Int max_threads
    String docker_image
    Int RAM
    Int threadCount
  }
  String bam_alignment = basename(alignment,".sam") + ".bam"
  #define command to execute when this task runs
  command {
    samtools sort -O BAM -@ ${max_threads} -o ${bam_alignment} ${alignment}
    samtools index -@ ${max_threads} ${bam_alignment}
  }
  #specify the output(s) of this task so cromwell will keep track of them
  output {
    File sorted_bam = "${bam_alignment}"
    File bam_index = "${bam_alignment}" + ".bai"
  }
  runtime {
    docker: docker_image
    memory: RAM + "GB"
    cpus: threadCount
  }
}
