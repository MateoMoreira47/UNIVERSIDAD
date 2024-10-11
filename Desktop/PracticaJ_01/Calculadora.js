function agregarProducto() {

    // Aqui se obtiene los campos del formulario //
    var productCode = document.getElementById("productCode").value;
    var productName = document.getElementById("productName").value;
    var price = parseFloat(document.getElementById("price").value);
    var quantity = parseInt(document.getElementById("quantity").value);

    // Se verificara si los valores ingresados son validos
    if (productCode === "" || productName === "" || isNaN(price) || isNaN(quantity) || quantity <= 0) {
        alert("Por favor, complete la información del producto correctamente.");
        return;
    }

    //Se calacula el total del producto
    var total = price * quantity;

    // Aquí se crea una nueva fila para agregar al cuerpo de la factura.
    var tbody = document.getElementById("invoiceBody");
    var row = document.createElement("tr");
    row.innerHTML = `
        <td>${productCode}</td>
        <td>${productName}</td>
        <td>$${price.toFixed(2)}</td>
        <td>${quantity}</td>
        <td>$${total.toFixed(2)}</td>
    `;
    // Se agrega la nueva fila al cuerpo de la factura.
    tbody.appendChild(row);

    actualizarTotales(); // Acatualizar facturas
    limpiarFormulario(); // Limpiar los campos del formulario
}

function actualizarTotales() {
    // Aquí se calcula el subtotal, el IVA y el total de la factura.
    var subtotal = 0;
    var iva = 0;

    var rows = document.getElementById("invoiceBody").getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var cells = rows[i].getElementsByTagName("td");
        var total = parseFloat(cells[4].innerText.replace("$", ""));
        subtotal += total;
    }

    iva = subtotal * 0.12;
    var total = subtotal + iva;

    // Aquí se actualizar los valores totales de la facturas
    document.getElementById("subtotal").innerText = subtotal.toFixed(2);
    document.getElementById("iva").innerText = iva.toFixed(2);
    document.getElementById("total").innerText = total.toFixed(2);
}

function limpiarFormulario() {
    // Aquí se limpian los campos del formulario
    document.getElementById("productCode").value = "";
    document.getElementById("productName").value = "";
    document.getElementById("price").value = "";
    document.getElementById("quantity").value = "";
}