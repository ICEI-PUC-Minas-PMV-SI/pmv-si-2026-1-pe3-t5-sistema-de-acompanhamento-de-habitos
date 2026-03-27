<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::disableForeignKeyConstraints();

        Schema::create('auditorias', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('usuario_id');
            $table->foreign('usuario_id')->references('id')->on('usuarios');
            $table->string('tipo_evento');
            $table->string('evento');
            $table->date('dt_criacao');
        });

        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('auditorias');
    }
};
