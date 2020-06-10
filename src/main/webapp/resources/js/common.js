$(document).ready(function(){
    $('.p5_button_list .p5_numb').click(function(){
        $(this).addClass('p5_be_green')
        $(this).siblings('.p5_numb').removeClass('p5_be_green')
    })
})