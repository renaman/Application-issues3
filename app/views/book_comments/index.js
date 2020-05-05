$("comment_area").html("<%= j (render 'comment', { comments: @comment })");
$("textarea").val('')