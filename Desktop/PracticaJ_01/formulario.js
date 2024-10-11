'use strict'

window.addEventListener('load',function()
{
    console.log("DOM cargado!!");

    var formulario = document.querySelector("#formulario");
    var box_dashed = document.querySelector(".dashed");
    box_dashed.style.display= "none";

    formulario.addEventListener('submit', function(){
        console.log("Evento submit capturado");

        var nombre = document.querySelector("#nombre").value;
        var apellidos = document.querySelector("#apellidos").value;
        var edad = parseInt(document.querySelector("#edad").value);
        var cedula = parseInt(document.querySelector("#cedula").value);

        if(nombre.trim()==null || nombre.trim().length==0){
        alert("el nombre no es válido");
        document.querySelector("#error_nombre").innerHTML="El nombre no es válido";
        return false;
    }else{
        document.querySelector("#error_nombre").style.display="none";
    }
    if(apellidos.trim()==null || apellidos.trim().length==0){
        alert("el apellido no es válido");
        return false;
        
    }
    if(edad==null || edad<=0 || isNaN(edad)){
        alert("la edad no es válida");
        return false;
    }

    if(cedula==null || cedula<=0 || isNaN(cedula)){
        alert("la cedula no es válida");
        return false;
    }
        box_dashed.style.display= "block";
        var p_nombre= document.querySelector("#p_nombre span");
        var p_apellidos= document.querySelector("#p_apellidos span");
        var p_edad= document.querySelector("#p_edad span");
        var p_cedula= document.querySelector("#p_cedula span");
        p_nombre.innerHTML=nombre;
        p_apellidos.innerHTML=apellidos;
        p_edad.innerHTML=edad;
        p_cedula.innerHTML=cedula;
        

        
    });
    
})