<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */
    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    /**
     * Attempt to log the user into the application with multi-identifier support.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return bool
     */
    protected function attemptLogin(\Illuminate\Http\Request $request)
    {
        $login = trim($request->input('email'));
        $password = $request->input('password');
        $remember = $request->filled('remember');

        // 1. Coba login langsung dengan email
        if ($this->guard()->attempt(['email' => $login, 'password' => $password], $remember)) {
            return true;
        }

        // 2. Coba login dengan name / username
        if ($this->guard()->attempt(['name' => $login, 'password' => $password], $remember)) {
            return true;
        }

        // 3. Fallback jika user input 'admin' tanpa domain email
        if (strpos($login, '@') === false && $this->guard()->attempt(['email' => $login . '@gmail.com', 'password' => $password], $remember)) {
            return true;
        }

        return false;
    }
}
