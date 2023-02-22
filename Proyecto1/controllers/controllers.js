
exports.cons1 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 1", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}


exports.cons2 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 2", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons3 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 3", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons4 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 4", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons5 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 5", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons6 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 6", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.cons7 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 7", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}
exports.cons8 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 8", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}
exports.cons9 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 9", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}
exports.cons10 = async function(req,res){
    try{
        res.status(200).send({msg:"Consulta 10", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.deleteTemp = async function(req,res){
    try{
        res.status(200).send({msg:"eliminarTemporal", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.deleteMod = async function(req,res){
    try{
        res.status(200).send({msg:"eliminarModelo", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.chargeTemp = async function(req,res){
    try{
        res.status(200).send({msg:"cargarTemporal", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}

exports.chargeModel = async function(req,res){
    try{
        res.status(200).send({msg:"cargarModelo", valid:true})
    }catch(error){
        res.status(400).send({msg:"error en server"})
    }
}