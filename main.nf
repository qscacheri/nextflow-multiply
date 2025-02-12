#!/usr/bin/env nextflow 
import groovy.json.JsonOutput

nextflow.enable.dsl=2

process multiply {
    container "736855904193.dkr.ecr.us-east-1.amazonaws.com/convergence-base"
    publishDir params.output.product._outputDir, mode: "copy"
    input:  
        val num1
        val num2
    output:
        path("product.txt")
    shell:
        '''
        echo "!{num1}*!{num2}" | bc > product.txt
        '''
}

workflow {
    multiply(params.input.num1._value, params.input.num2._value)
}
