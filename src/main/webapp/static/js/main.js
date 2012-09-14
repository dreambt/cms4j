// 时间格式化
function ChangeDateFormat(cellval) {
    if(null==cellval) return 0;
    var datetime = cellval.toString().split(",");
    var month = datetime[1] < 10 ? "0" + (datetime[1]) : datetime[1];
    var currentDate = datetime[2] < 10 ? "0" + datetime[2] : datetime[2];
    return datetime[0] + "年" + month + "月" + currentDate + "日";
}
function ChangeDateTimeFormat(cellval) {
    if(null==cellval) return 0;
    var datetime = cellval.toString().split(",");
    var month = datetime[1] < 10 ? "0" + (datetime[1]) : datetime[1];
    var currentDate = datetime[2] < 10 ? "0" + datetime[2] : datetime[2];
    var hour = datetime[3] < 10 ? "0" + datetime[3] : datetime[3];
    var min = datetime[4] < 10 ? "0" + datetime[4] : datetime[4];
    var sec = datetime[5] < 10 ? "0" + datetime[5] : datetime[5];
    return datetime[0] + "年" + month + "月" + currentDate + "日 " + hour + ":" + min + ":" + sec;
}
function PostByAjax(url, data) {
    $.ajax({
        url:url,
        type: "POST",
        data: data,
        timeout:3000
    }).done(function(msg) {
            if(0==msg.status){
                type = "error";
                message = msg.message+" 请检查提交参数后再次尝试！";
            } else {
                type = "info";
                message="操作成功！";
            }
            $.msgGrowl ({
                type: type,
                position:"top-right",
                'text': message,
                lifetime: 5000
            });
        });
}
$(function(){
    // checkbox 全选与全部取消
    if($('#checkedAll').length>0)  {
        $('#checkedAll').click(function(){
            if(this.checked){
                $(":checkbox").each(function(){this.checked=true});
            }else{
                $(":checkbox").each(function(){this.checked=false});
            }
        });
    }
});