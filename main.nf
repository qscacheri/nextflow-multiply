nextflow.enable.dsl=2
params.num1 = ""
params.num2 = ""
params.outputDir = ""
process multiply {
    input:
        val num1
        val num2
        path outputDir
    shell:
        '''
        echo "!{num1}*!{num2}" | bc > !{outputDir}/product.txt
        '''
}
workflow {
    multiply(params.num1, params.num2, params.outputDir)
}