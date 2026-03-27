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

        Schema::create('habitos', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('categoria_id');
            $table->foreign('categoria_id')->references('id')->on('categorias');
            $table->bigInteger('usuario_id');
            $table->string('nome');
            $table->longText('descricao');
            $table->json('frequencia');
            $table->boolean('ativo');
            $table->date('dt_criacao');
        });

        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('habitos');
    }
};
