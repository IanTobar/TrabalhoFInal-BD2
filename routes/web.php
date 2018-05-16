<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {

    return view('welcome');
});


Route::get('/home', function () {
    $results = DB::select('select * from estado');

    foreach($results as $table){
    	foreach ($table as $tupla) {
    		echo $tupla," ";
    	}
    	echo "<br>";
	}
return view('welcome');
});

Route::get('/showTable/{tName?}','selectController@index');
Route::get('/searchIDHM/{mName?}/{eName?}/{ano?}/{classificao?}','selectController@searchIDHM');
