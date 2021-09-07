nextflow.enable.dsl=2
params.num1 = ""
params.num2 = ""
params.product = ""
process multiply {
    container "736855904193.dkr.ecr.us-east-1.amazonaws.com/convergence-base"
    input:
        val num1
        val num2
        path product
    shell:
        '''
        echo "!{num1}*!{num2}" | bc > !{product}/product.txt
        '''
}
workflow {
    multiply(params.num1, params.num2, params.product)
}