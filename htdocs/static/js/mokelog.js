Mokelog = ( function(){
    return {
        toggleAll : ( function() {
            var divHTMLTags=document.getElementsByTagName("div");
            for (i=0; i<divHTMLTags.length; i++) {
                if(divHTMLTags[i].className =='box-open'){
                    divHTMLTags[i].className = 'box-close';
                }
                else if (divHTMLTags[i].className =='box-close') {
                    divHTMLTags[i].className = 'box-open';
                }
            }
        }),
        toggle : ( function( id ) {
                if( document.getElementById(id).className  == 'box-open' ) {
                    document.getElementById(id).className = 'box-close';
                }
                else {
                    document.getElementById(id).className = 'box-open';
                }
        })
    }
})();
