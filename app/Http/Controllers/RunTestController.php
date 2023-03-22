<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Redis;
use Laravel\Horizon\Contracts\JobRepository;
use Throwable;

class RunTestController extends Controller
{
    private const TEST_DB = 'db';
    private const TEST_CACHE = 'cache';
    private const TEST_HORIZON = 'horizon';

    public function __invoke(string $testType): JsonResponse
    {
        if ($testType === self::TEST_DB) {
            try {
                User::get();

                return response()->json(['passed' => true]);
            } catch (Throwable $exception) {
                return response()->json(['passed' => false, 'error' => $exception->getMessage()]);
            }
        }

        if ($testType === self::TEST_CACHE) {
            try {
                Redis::command('ping');

                return response()->json(['passed' => true]);
            } catch (Throwable $exception) {
                return response()->json(['passed' => false, 'error' => $exception->getMessage()]);
            }
        }

        if ($testType === self::TEST_HORIZON) {
            try {
                $jobRepository = app(JobRepository::class);

                $initialCompletedJobCount = $jobRepository->countCompleted();

                dispatch(static fn () => null);
                sleep(3); // Let horizon process the job...

                $newCompletedJobCount = $jobRepository->countCompleted();

                if ($newCompletedJobCount === $initialCompletedJobCount + 1) {
                    return response()->json(['passed' => true]);
                }

                return response()->json(['passed' => false, 'error' => 'Something went wrong - the job was not completed.']);
            } catch (Throwable $exception) {
                return response()->json(['passed' => false, 'error' => $exception->getMessage()]);
            }
        }

        return response()->json(['error' => 'No tests were ran.']);
    }
}
