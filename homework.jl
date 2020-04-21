f(x) = -x^4+x^3+x^2+1
g(x) = -4x^3+3x^2+2x
x0 = -2
dx = 10^-7
video = true
using Plots
#using Gadfly
function newton_method(f,g,x,dx,video)
    """The function looks for the zero of the f function using the Newton method,
     and in the case of video = true, illustrate this process with an animation.
        Args:
            f-function typr "f(x)"
            g-derivative of f function
            x-start value
            dx-accuracy
        Return:
            x-nearest function zero
            step-number of steps taken to zero function
    """

    step = 0 #initial number of steps
    lista_with_x_value = zeros(0) #kreate a list with zero to store the values of subsequent steps
    while (abs(f(x)) > dx) #while approximately equal zero thats mean more than accuracy
        x = x-f(x)/g(x) #Newton method
        append!(lista_with_x_value,x) #add new value of x to "lista_with_x_value"
        step += 1 # add step to "step"
        if step >= 1000 #so that the function does not fall into an infinite loop
            return x
        end
    end
    #for i in 0:length(lista) ##so that in line 50 was created "label"
    if video == true 
        xn = LinRange(-10-x,10+x,200)
        plot(xn,f.(xn),
            title = "Newton method",
            label = "f(x)", #the inskription in legend
            linecolor = :blue, #color of function
            linewidth = 3, #line thickness
            linealpha=0.5, #line transparency
            ylims = (-10,10), #side y axis
            framestyle = :origin, #makes the standard view of the x and y axis
            xlabel = "x", ylabel = "y", #name of axis
            xticks = ([i for i in -10-floor(x):10+floor(x)]),yticks = ([i for i in -10:10]) #inscriptions or divisions on the x and y axis
            ) |> display #create f(x) function
        anim=@animate for i in 1:step #creta a animate of point appearing
            scatter!(lista_with_x_value[1:i],f.(lista_with_x_value)[1:i], #point coordinates
                markercolor = :red, #point color
                markersize = 4.44, #point size
                marker = stroke(2, 2, :black, :dot), #view of the circle around point
                #label = "x" * string(i), #the inskription in legend
                series_annotations = text.(["x$k" for k in 0:length(lista_with_x_value)], :top)#signature on point
                ) |> display #create points
        end
        #gif(anim, "Newton.gif", fps = 2)
    end
    gif(anim, "Newton.gif", fps = 2)#create a plik with .gif format which contain visualization of Newton method
    return x,step
    
end

newton_method(f,g,x0,dx,video)
