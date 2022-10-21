// JavaScript Document


var file_description_fr = [
	{
		"title":"French 2 words sequences",
		"description":"The Part-of-Speech-tagged 2-gram lexicon containing e.g. <b>meilleure_ADJ négociatrice_NOUN</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/FRE2_general.csv.gz",
		"filenamexlsx":"data/FRE2_million.xlsx",
		"applink":"apps/?lang=FRE&n=2",
		"nblines":"7,548,063",
	},
	{
		"title":"French 3 words sequences",
		"description":"The Part-of-Speech-tagged 3-gram lexicon containing e.g. <b>la_DET messe_NOUN ésotérique_ADJ</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/FRE3_general.csv.gz",
		"filenamexlsx":"data/FRE3_million.xlsx",
		"applink":"apps/?lang=FRE&n=3",
		"nblines":"15,425,851",
	},
	{
		"title":"French 4 words sequences",
		"description":"The Part-of-Speech-tagged 4-gram lexicon containing e.g. <b>pour_ADP apaiser_VERB son_DET chagrin_NOUN</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/FRE4_general.csv.gz",
		"filenamexlsx":"data/FRE4_million.xlsx",
		"applink":"apps/?lang=FRE&n=4",
		"nblines":"16,313,733",
	},
	{
		"title":"French 5 words sequences",
		"description":"The Part-of-Speech-tagged 5-gram lexicon containing e.g. <b>en_ADP moins_ADV de_ADP trois_DET ans_NOUN</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/FRE5_general.csv.gz",
		"filenamexlsx":"data/FRE5_million.xlsx",
		"applink":"apps/?lang=FRE&n=5",
		"nblines":"12,412,134"
	}
];

var file_description_en = [
	{
		"title":"English 2 words sequences",
		"description":"The Part-of-Speech-tagged 2-gram lexicon containing e.g. <b>same_ADJ sentiment_NOUN</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/ENG2_general.csv.gz",
		"filenamexlsx":"data/ENG2_million.xlsx",
		"applink":"apps/?lang=ENG&n=2",
		"nblines":"8,161,430",
	},
	{
		"title":"English 3 words sequences",
		"description":"The Part-of-Speech-tagged 3-gram lexicon containing e.g. <b>colours_NOUN were_VERB different_ADJ</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/ENG3_general.csv.gz",
		"filenamexlsx":"data/ENG3_million.xlsx",
		"applink":"apps/?lang=ENG&n=3",
		"nblines":"15,448,922",
	},
	{
		"title":"English 4 words sequences",
		"description":"The Part-of-Speech-tagged 4-gram lexicon containing e.g. <b>the_DET prescribed_VERB time_NOUN limit_NOUN</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/ENG4_general.csv.gz",
		"filenamexlsx":"data/ENG4_million.xlsx",
		"applink":"apps/?lang=ENG&n=4",
		"nblines":"15,116,507",
	},
	{
		"title":"English 5 words sequences",
		"description":"The Part-of-Speech-tagged 5-gram lexicon containing e.g. <b>the_DET life_NOUN and_CONJ death_NOUN struggle_NOUN</b> with its annual frequency averaged over the period 2012-2019",
		"filename":"data/ENG5_general.csv.gz",
		"filenamexlsx":"data/ENG5_million.xlsx",
		"applink":"apps/?lang=ENG&n=5",
		"nblines":"10,602,231"
	}
];





var fr_app_cards_html = "";
var en_app_cards_html = "";
var i = 0;




for (i=0; i<file_description_fr.length; i++){

	fr_app_cards_html +=
	"<div class='col-md-6'> " +
	"  <div class='card'> " +
	"    <img class='card-img-top' src='img/shiny_logo.png' alt='shiny app'> " +
	"    <div class='card-body'> " +
	"      <h4 class='card-title' style='color: #293a44;'>" + file_description_fr[i].title + "</h4> " +
	"      <h6 class='card-subtitle mb-2 text-muted'>" + file_description_fr[i].nblines  + " word sequences</h6>" +
	"      <p class='card-text'>" + file_description_fr[i].description + "</p> " +
	"      <br><br> " +
	"      <div class='btn-toolbar float-right' role='toolbar' aria-label='Toolbar with button groups'>" +
	"        <div class='btn-group mr-2' role='group' aria-label='First group'>" +
	"          <a href='"+ file_description_fr[i].filename +"' class='btn btn-secondary'>Download csv file<br>(all sequences, gzipped)</a> " +
	"        </div>" +
	"        <div class='btn-group mr-2' role='group' aria-label='First group'>" +
	"          <a href='"+ file_description_fr[i].filenamexlsx +"' class='btn btn-secondary'>Download xlsx file<br>(a million sequences)</a> " +
	"        </div>" +
	"        <div class='btn-group mr-2' role='group' aria-label='Second group'>" +
	"          <a href='"+ file_description_fr[i].applink +"' class='btn btn-info'>Launch<br>app</a> " +
	"        </div>" +
	"      </div>" +
	"    </div> " +
	"  </div> " +
	"</div> ";

}


for (i=0; i<file_description_en.length; i++){

	en_app_cards_html +=
	"<div class='col-md-6'> " +
	"  <div class='card'> " +
	"    <img class='card-img-top' src='img/shiny_logo.png' alt='shiny app'> " +
	"    <div class='card-body'> " +
	"      <h4 class='card-title' style='color: #293a44;'>" + file_description_en[i].title + "</h4> " +
	"      <h6 class='card-subtitle mb-2 text-muted'>" + file_description_en[i].nblines  + " word sequences</h6>" +
	"      <p class='card-text'>" + file_description_en[i].description + "</p> " +
	"      <br><br> " +
	"      <div class='btn-toolbar float-right' role='toolbar' aria-label='Toolbar with button groups'>" +
	"        <div class='btn-group mr-2' role='group' aria-label='First group'>" +
	"          <a href='"+ file_description_en[i].filename +"' class='btn btn-secondary'>Download csv files<br>(all sequences, gzipped)</a> " +
	"        </div>" +
	"        <div class='btn-group mr-2' role='group' aria-label='First group'>" +
	"          <a href='"+ file_description_en[i].filenamexlsx +"' class='btn btn-secondary'>Download xlsx file<br>(a million sequences)</a> " +
	"        </div>" +
	"        <div class='btn-group mr-2' role='group' aria-label='Second group'>" +
	"          <a href='"+ file_description_en[i].applink +"' class='btn btn-info'>Launch<br>app</a> " +
	"        </div>" +
	"      </div>" +
	"    </div> " +
	"  </div> " +
	"</div> ";

}



$('#shinyapp-fr').html(fr_app_cards_html);
$('#shinyapp-en').html(en_app_cards_html);
