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

        Schema::create('lembretes', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('habito_id');
            $table->time('horario_disparo');
            $table->foreign('horario_disparo')->references('categoria_id')->on('habitos');
            $table->json('dias_disparo');
            $table->boolean('ativo');
        });

        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lembretes');
    }
};
