var divToChange = document.GetElementById("divToChange");
var divAsHover = document.GetElementById("divAsHover");
var changeColor = function () {
    divToChange.style.backgroundColor = "#yellow";
}
divAsHover.addEventListener("mousemove", changeColor);
