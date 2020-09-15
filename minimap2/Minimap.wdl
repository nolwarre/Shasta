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
   output { File sorted_bam = samtools.sorted_bam}
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
  #define command to execute when this task runs
  command {
    minimap2 -a -x map-ont -t \
    ${max_threads} \
    ${assembly} \
    ${reads} > alignment.sam
  }
  #specify the output(s) of this task so cromwell will keep track of them
  output {
    File sam_alignment = "alignment.sam"
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
  #define command to execute when this task runs
  command {
    samtools sort -O BAM -@ ${max_threads} -o alignment.sorted.bam ${alignment}
    samtools index -@ ${max_threads} alignment.sorted.bam
    cat alignment.sorted.bam > alignment.sort.bam
  }
  #specify the output(s) of this task so cromwell will keep track of them
  output {
    File sorted_bam = "alignment.sort.bam"
  }
  runtime {
    docker: docker_image
    memory: RAM + "GB"
    cpus: threadCount
  }
}
