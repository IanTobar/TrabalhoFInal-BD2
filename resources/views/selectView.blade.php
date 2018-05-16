@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-offset-1">

                <div class="panel-group" style="text-align: center;">
            
<div class="panel panel-success animatedLong fadeIn">

    	 
  
<table class="table">
  <thead class="thead-dark">
    <tr>
      <th scope="col">#</th>
      <th scope="col">Cidade</th>
      <th scope="col">Valor</th>
    </tr>
  </thead>
  <tbody>

    @foreach($tables as $tupla)
    <tr>
      @foreach($tupla as $collum)
      <td> {{$collum}} </td>
    
  
@endforeach
</tr>

@endforeach
</tbody>
</table>
  
 </div>



            </div>
        </div>
    </div>
  </div>
@endsection