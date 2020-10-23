$(document).on('turbolinks:load', function(){
  console.log("yaho")
  function buildHTML(index){
    var html = 
    `<div class="field__scorer" data-index="${index}>
      <label for="game_result_game_scorers_attributes_${index}_自チーム得点者">自チーム得点者</label>
      <br>
      <select class="input-form" name="game_result[game_scorers_attributes][${index}][user_id]" id="game_result_game_scorers_attributes_${index}_user_id"><option value="1">testユーザー</option></select>
    </div>`
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $('.field__scorer:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('button').on('click', function(e){
    console.log(this)
    const targetIndex = $(this).parent().data('index');
    e.preventDefault();
    let html = buildHTML(fileIndex[0]);
    $("#a").append(html);
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
  })
});