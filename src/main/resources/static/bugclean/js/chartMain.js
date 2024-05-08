google.charts.load('current', {packages: ['corechart']});
google.charts.setOnLoadCallback(drawChart);

let january;
let february;
let march;
let april;
let may;
let june;
let july;
let august;
let september;
let october;
let november;
let december;

var chart;
var data;
var option;

let now = new Date();	// 현재 날짜 및 시간
let year = now.getFullYear();	// 연도


function drawChart() {
for(let i=1;i<=12;i++){
   fetch("/chart/getPrice",{
        method : 'POST',
        headers: {
            "Content-Type": "application/json",
          },
        body : JSON.stringify({
            i
        })
    }).then(res=>res.json())
    .then(res=>{
        if(i==1){
            january = res;
        }else if(i==2){
            february = res;
        }else if(i==3){
            march = res;
        }else if(i==4){
            april = res;
        }else if(i==5){
            may = res;
        }else if(i==6){
            june = res;
        }else if(i==7){
            july = res;
        }else if(i==8){
            august = res;
        }else if (i==9){
            september =res;
        }else if(i==10){
            october = res;
        }else if(i==11){
            november = res;
        }else if (i==12){
            december = res;
        }

    }).then(()=>{
        if(i == 12) {
            data = google.visualization.arrayToDataTable([
                ['Year', '매출', { role: 'style' } ],
                ['1월', january, 'color: gray'],
                ['2월', february, 'color: #76A7FA'],
                ['3월', march, 'opacity: 0.2'],
                ['4월', april, 'color: #E0C8C0; '],
                ['5월', may, 'color: #FFAA3E; width: 8;'],
                ['6월', june, 'color: #FFF462; width: 4; '],
                ['7월', july, 'color: #F0F0F0; width: 4; '],
                ['8월', august, 'color: #E7E7E7; width: 4; '],
                ['9월', september, 'color: #E2E1EE; width: 4; '],
                ['10월', october, 'color: #E8DEDC; width: 4;'],
                ['11월', november, 'color: #9E9E9E; width: 4; '],
                ['12월', december, 'color: #FFE4E1; width: 4; '],
                
            ]);
             options = {
            title: year + '년 매출 현황',
            height : 400,
            hAxis: {
              title: '월 별 매출'
            },
            vAxis: {
              title: '단위 : 원'
            }
          };
          
          chart= new google.visualization.ColumnChart(
              document.getElementById('chart_div'));
            chart.draw(data, options);}
    })
}

}