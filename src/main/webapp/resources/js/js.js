function xssChange(data){
    var strReturenValue = "";
    strReturenValue = data.replace(/&/gi, '&amp;').replace(/</gi, '&lt;').replace(/>/gi, '&gt;').replace(/"/gi, '&quot;').replace(/'/gi, '&apos;');
    return strReturenValue;
}

function changeOutValue(data) {
    var strReturenValue = "";
    strReturenValue = data.replace(/&amp;/gi, '&').replace(/&lt;/gi, '<').replace(/&gt;/gi, '>').replace(/&quot;/gi, '"').replace(/&apos;/gi, '\'').replace(/&nbsp;/gi, ' ');
    return strReturenValue;
}
