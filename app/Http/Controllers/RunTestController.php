<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Redis;
use Throwable;

class RunTestController extends Controller
{
    private const TEST_DB = 'db';
    private const TEST_CACHE = 'cache';

    public function __invoke(string $testType): JsonResponse
    {
        $passed = true;
        $error = null;

        try {
            if ($testType === self::TEST_DB) {
                User::get();
            }

            if ($testType === self::TEST_CACHE) {
                Redis::command('ping');
            }
        } catch (Throwable $exception) {
            $passed = false;
            $error = $exception->getMessage();
        }

        return response()->json(compact('passed', 'error'));
    }
}
