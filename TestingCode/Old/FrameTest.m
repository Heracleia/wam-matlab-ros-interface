%% Test the frame function    

    T=eye(4);
    varargin=cell(1);

    if isscalar(T) && ishandle(T)
        % trplot(H, T)
        H = T; 
        T = varargin{1};
        if isrot(T)
            T = r2t(T);
        end
        set(H, 'Matrix', T);
        
        % for the 3D case retrieve the right hgtransform and set it
        hg2 = get(H, 'UserData');
        if ~isempty(hg2)
            set(hg2, 'Matrix', T);
        end
        
        return;
    end

    if size(T,3) > 1
        error('trplot cannot operate on a sequence');
    end
    if ~ishomog(T) && ~isrot(T)
        error('trplot operates only on transform (4x4) or rotation matrix (3x3)');
    end
    
    opt.color = [];
    opt.rgb = false;
    opt.axes = true;
    opt.axis = [];
    opt.frame = [];
    opt.text_opts = [];
    opt.view = [];
    opt.width = 1;
    opt.arrow = false;
    opt.labels = 'XYZ';
    opt.handle = [];
    opt.anaglyph = 'rc';
    opt.d_3d = false;
    opt.dispar = 0.1;
    opt.thick = 0.5;
    opt.length = 1;
    opt.text = true;

    opt = tb_optparse(opt, varargin);

    if ~isempty(opt.color) && opt.d_3d
        error('cannot specify ''color'' and ''3d'', use ''anaglyph'' option');
    end
    if isempty(opt.color)
        opt.color = 'b';
    end
    if isempty(opt.text_opts)
        opt.text_opts = {};
    end
    
    if opt.d_3d
        opt.color = ag_color(opt.anaglyph(1));
    end
    
    if isempty(opt.axis)
        % determine some default axis dimensions
        
        % get the origin of the frame
        if isrot(T)
            c = [0 0 0];  % at zero for a rotation matrix
        else
            c = transl(T);    
        end
        
        d = 1.2;
        opt.axis = [c(1)-d c(1)+d c(2)-d c(2)+d c(3)-d c(3)+d];
        
    end
    
    % TODO: should do the 2D case as well
    
    if ~isempty(opt.handle)
        hax = opt.handle;
        hold(hax);
    else
        ih = ishold;
        if ~ih
            % if hold is not on, then clear the axes and set scaling
            cla
            if ~isempty(opt.axis)
                axis(opt.axis);
            end
            daspect([1 1 1]);
            
            if opt.axes
                xlabel( 'X');
                ylabel( 'Y');
                zlabel( 'Z');
                rotate3d on
            end
            new_plot = true;
        end
        hax = gca;
        hold on
    end
    % hax is the handle for the axis we will work with, either new or
    % passed by option 'handle'

    opt.text_opts = [opt.text_opts, 'Color', opt.color];


    hg = hgtransform('Parent', hax);


    % trplot( Q.R, fmt, color);
    if isrot(T)
        T = r2t(T);
    end

    % create unit vectors
    o =  [0 0 0]';
    x1 = opt.length*[1 0 0]';
    y1 = opt.length*[0 1 0]';
    z1 = opt.length*[0 0 1]';
    
    % draw the axes
    
    mstart = [o o o]';
    mend = [x1 y1 z1]';

    if opt.rgb
        axcolors = {'r', 'g', 'b'};
    else
        axcolors = { opt.color, opt.color, opt.color};
    end
    
    if opt.arrow
%         % draw the 3 arrows
%         S = [opt.color num2str(opt.width)];
%         ha = arrow3(mstart, mend, S);
%         for h=ha'
%             set(h, 'Parent', hg);
%         end
          for i=1:3
              ha = arrow3(mstart(i,1:3), mend(i,1:3), [axcolors{i} num2str(opt.width)]);
              set(ha, 'Parent', hg);
          end
    else
        for i=1:3
            plot2([mstart(i,1:3); mend(i,1:3)], 'Color', axcolors{i}, ...
                'LineWidth', opt.thick, ...
                'Parent', hg);
        end
    end
    
    % label the axes
    if isempty(opt.frame)
        fmt = '%c';
    else
        fmt = sprintf('%%c_{%s}', opt.frame);
    end
    
    if opt.text
        % add the labels to each axis
        h = text(x1(1), x1(2), x1(3), sprintf(fmt, opt.labels(1)), 'Parent', hg);
        set(h, opt.text_opts{:});
        
        h = text(y1(1), y1(2), y1(3), sprintf(fmt, opt.labels(2)), 'Parent', hg);
        set(h, opt.text_opts{:});
        
        h = text(z1(1), z1(2), z1(3), sprintf(fmt, opt.labels(3)), 'Parent', hg);
        set(h, opt.text_opts{:});
    end
    
    % label the frame
    if ~isempty(opt.frame)
        h = text(o(1)-0.04*x1(1), o(2)-0.04*y1(2), o(3)-0.04*z1(3), ...
            ['\{' opt.frame '\}'], 'Parent', hg);
        set(h, 'VerticalAlignment', 'middle', ...
            'HorizontalAlignment', 'center', opt.text_opts{:});
    end
    
    if ~opt.axes
        set(gca, 'visible', 'off');
    end
    if ischar(opt.view) && strcmp(opt.view, 'auto')
        cam = x1+y1+z1;
        view(cam(1:3));
    elseif ~isempty(opt.view)
        view(opt.view);
    end
    if isempty(opt.handle) && ~ih
        grid on
        hold off
    end
    
    % now place the frame in the desired pose
    set(hg, 'Matrix', T);

    
    if opt.d_3d
        % 3D display.  The original axes are for the left eye, and we add 
        % another set of axes to the figure for the right eye view and
        % displace its camera to the right of that of that for the left eye.
        % Then we recursively call trplot() to create the right eye view.
        
        left = gca;
        right = axes;
        
        % compute the offset in world coordinates
        off = -t2r(view(left))'*[opt.dispar 0 0]';
        pos = get(left, 'CameraPosition');
        
        set(right, 'CameraPosition', pos+off');
        set(right, 'CameraViewAngle', get(left, 'CameraViewAngle'));
        set(right, 'CameraUpVector', get(left, 'CameraUpVector'));
        target = get(left, 'CameraTarget');
        set(right, 'CameraTarget', target+off');
        
        % set perspective projections
                set(left, 'Projection', 'perspective');
        set(right, 'Projection', 'perspective');
        
        % turn off axes for right view
        set(right, 'Visible', 'Off');
        
        % set color for right view
        hg2 = trplot(T, 'color', ag_color(opt.anaglyph(2)));
        
        % the hgtransform for the right view is user data for the left
        % view hgtransform, we need to change both when we rotate the 
        % frame.
        set(hg, 'UserData', hg2);
    end

    % optionally return the handle, for later modification of pose
    if nargout > 0
        hout = hg;
    end