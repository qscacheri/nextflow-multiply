#!/usr/bin/env nextflow 
import groovy.json.JsonOutput

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
        env product
    shell:
        '''
        product=$(bc <<< "!{num1}*!{num2}")
        '''
}

process getProductJSON {
        container "736855904193.dkr.ecr.us-east-1.amazonaws.com/convergence-base"
    publishDir params.product, mode: "copy"
    input: 
        val product
    output:
        path "out.json"
    shell:
    '''
    #!/usr/bin/env python

    import json
    output = {"_value": !{product}}
    with open("out.json", "w+") as f:
        f.write(json.dumps(output))
            
    '''
}
workflow {
    
    
    multiply(params.num1._value, params.num2._value)
    getProductJSON(multiply.out)
}