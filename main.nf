nextflow.enable.dsl=2
params.num1 = ""
params.num2 = ""
params.product = ""
process multiply {
    container "736855904193.dkr.ecr.us-east-1.amazonaws.com/convergence-base"
    publishDir params.product, mode: "copy"
    input:
        val num1
        val num2
    output:
        path "product.txt"
    shell:
        '''
        echo "!{num1}*!{num2}" | bc > product.txt
        '''
}
workflow {
    multiply(params.num1, params.num2)
}