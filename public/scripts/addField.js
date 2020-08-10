// Procurar o botao, quando clicar, clonar
document.querySelector("#add-time").addEventListener('click', cloneField);
// executar uma acao,
function cloneField() {
    // duplicar os campos. que campos? 
    const newFieldContainer = document.querySelector('.schedule-item').cloneNode(true); //no JS, Node é referência ao HTML
    // limpar os campos.
    const fields = newFieldContainer.querySelectorAll('input');
    //para cada campo, limpar.
    fields.forEach(function (field) {
        //pegar o field do momento e limpa ele
        field.value = ""; 
    })
    // colocar na página. onde?
    document.querySelector('#schedule-items').appendChild(newFieldContainer);
} 


