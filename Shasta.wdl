##############################################################################################
# run workflow:
#   dockstore workflow launch --local-entry Shasta.wdl --json shasta.json
###############################################################################################
#set wdl version
version 1.0

#add and name a workflow block
workflow shastaWorkflow {
   call shasta
   output { File assembly = shasta.outFile}
}

#define the 'shasta' task
task shasta {
  input {
    File reads
    File config
    String outdirectory
    String docker_image
    Int RAM
    Int threadCount
  }
  #define command to execute when this task runs
  #implementing config in the command will result in input not being read.
  command {
    /usr/src/shasta-Ubuntu-20.04/bin/shasta \
    --input ${reads} \
    --assemblyDirectory ${outdirectory} \
    --config ${config}
    cat "./${outdirectory}/Assembly.fasta" > Assembly.fasta
  }
  #specify the output(s) of this task so cromwell will keep track of them
  output {
    File outFile = "Assembly.fasta"
  }
  runtime {
    docker: docker_image
    memory: RAM + "GB"
    cpus: threadCount
  }
}
