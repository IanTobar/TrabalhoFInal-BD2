<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class selectController extends Controller
{
		public function index(Request $request){

			if($request['tName'] != NULL)
			{

			$sql = 'select * from ';
			$sql .= $request['tName'];

		 	$table = DB::select($sql);

		 	if($table == null)
		 		echo "Tabela Nula";

		 	return view('selectView',['tables'=>$table]);
		}
	}

	public function searchIDHM(Request $request,$mName = NULL,$eName = NULL,$ano = NULL,$classificacao = NULL){
		$search = new selectController();
		$municipioID = NULL;
		if($request->route('mName') != NULL)
			$municipioID = $search->findMunicioID($request['mName']);
		$estadoID = NULL;
		if($request['eName'] != NULL)
			$estadoID = $search->findEstadoID($request['eName']);
		$ano = $request['ano'];
		$classificacao = $request['classificacao'];

		$numOfFilters = 0;
		if($municipioID != NULL) $numOfFilters++;
		if($estadoID != NULL) $numOfFilters++;
		if($ano != NULL) $numOfFilters++;
		if($classificacao != NULL) $numOfFilters++;

		$sql = 'select indicativos_municipio.*, municipio.id_estado
		from indicativos_municipio
		inner join municipio
		on municipio.id_municipio = indicativos_municipio.id_municipio';

		$needAnd = false;

		if($municipioID != NULL || $estadoID != NULL || $ano != NULL || $classificacao != NULL)
			$sql .= ' where ';

		if($municipioID != NULL){
			$sql .= 'id_municipio = '.$municipioID;
			$numOfFilters--;
		}

		if($numOfFilters > 1){
			$needAnd = true;
		}
		//else return DB::select($sql);

		if($estadoID != NULL){
			if($needAnd)
				$sql .= 'AND id_estado = '.$estadoID;
			else $sql .= 'id_estado = '.$estadoID;
			$numOfFilters--;
			$needAnd = false;
		}

		if($numOfFilters > 1){
			$needAnd = true;
		}
		//else return DB::select($sql);

		if($ano != NULL){
			if($needAnd)
				$sql .= 'AND ano = '.$ano;
			else $sql .= 'ano = '.$ano;
			$numOfFilters--;
			$needAnd = false;
		}

		if($numOfFilters > 1){
			$needAnd = true;
		}//else return DB::select($sql);

		if($classificacao != NULL){
			if($needAnd)
			$sql .= 'AND classificacao = '.$classificacao;
			else $sql .= 'classificacao = '.$classificacao;
		}

		//return DB::select($sql);

		$result = DB::select($sql);

		echo $sql;

		foreach($result as $tuplas){
			foreach($tuplas as $colunas)
				echo $colunas," | ";
			echo "<br>";
		}
	}

	private function findEstadoID($eName){
		$sql = 'select id_estado from estado where nome_estado = ';
		$sql .= $eName;
		return DB::select($sql);
	}

	private function findMunicioID($mName){
		$sql = 'select id_municipio from municipio where nome_municipio = ';
		$sql .= $mName;
		return DB::select($sql);
	}
}
