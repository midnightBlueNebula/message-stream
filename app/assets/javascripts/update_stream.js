setInterval(() => {
    time = Date.new
    $.get({
        url: "stream.json",
        dataType: "json",
        success: (data) => {
            data.forEach((d) => {
                dTime = new Date(d.created_at.replace(" +0000", ""));
                if(dTime >= time){
                    $("#stream-section").prepend(renderHTML(d));
                }
            });
        }
    });
}, 1000);

function renderHTML(data) {
    return `<section class='render-post'>
    <p class='user-name'>${data.user.name}</p> | 
    <p class="karma" id="karma-${data.id}">${data.karma}</p>
    <p class="post-content">${data.content}</p>
    <span class="like">
    <form action="/like/message" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
    <input value="318" type="hidden" name="like[post_id]" id="like_post_id" />
    <input type="submit" name="commit" value="like" data-disable-with="like" />  
    </form>
    </span>
    <span class="dislike">
    <form action="/dislike/message" accept-charset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
    <input value="318" type="hidden" name="dislike[post_id]" id="dislike_post_id" />
    <input type="submit" name="commit" value="dislike" data-disable-with="dislike" />  
    </form>
    </span>
    <section/>`
};