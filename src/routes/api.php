<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

/**
 * @group User Management
 *
 * APIs for managing users
 */
Route::prefix('v1')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    })->middleware('auth:sanctum');

    /**
     * Get user profile
     * 
     * Returns the profile information for the authenticated user.
     *
     * @authenticated
     * 
     * @response 200 {
     *  "id": 1,
     *  "name": "John Doe",
     *  "email": "john@example.com",
     *  "created_at": "2024-03-20T12:00:00Z",
     *  "updated_at": "2024-03-20T12:00:00Z"
     * }
     */
    Route::get('/profile', function (Request $request) {
        return $request->user();
    })->middleware('auth:sanctum');

    /**
     * Update user profile
     * 
     * Updates the profile information for the authenticated user.
     *
     * @authenticated
     * 
     * @bodyParam name string required The name of the user. Example: John Doe
     * @bodyParam email string required The email of the user. Example: john@example.com
     * 
     * @response 200 {
     *  "message": "Profile updated successfully"
     * }
     */
    Route::put('/profile', function (Request $request) {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,' . $request->user()->id,
        ]);

        $request->user()->update($request->only(['name', 'email']));

        return response()->json(['message' => 'Profile updated successfully']);
    })->middleware('auth:sanctum');
}); 