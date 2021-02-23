classdef Arena_GUI_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        ConnectionPanel            matlab.ui.container.Panel
        ConnectionLampLabel        matlab.ui.control.Label
        ConnectionLamp             matlab.ui.control.Lamp
        PortDropDownLabel          matlab.ui.control.Label
        PortDropDown               matlab.ui.control.DropDown
        DisconnectButton           matlab.ui.control.Button
        ConnectButton              matlab.ui.control.Button
        RefreshButton              matlab.ui.control.Button
        ModelDropDownLabel         matlab.ui.control.Label
        ModelDropDown              matlab.ui.control.DropDown
        TabGroup                   matlab.ui.container.TabGroup
        ArenaControlTab            matlab.ui.container.Tab
        ManualRedLEDPanels         matlab.ui.container.Panel
        UpperLeftSwitchLabel       matlab.ui.control.Label
        UpperLeftSwitch            matlab.ui.control.Switch
        UpperRightSwitchLabel      matlab.ui.control.Label
        UpperRightSwitch           matlab.ui.control.Switch
        LowerLeftSwitchLabel       matlab.ui.control.Label
        LowerLeftSwitch            matlab.ui.control.Switch
        LowerRightSwitchLabel      matlab.ui.control.Label
        LowerRightSwitch           matlab.ui.control.Switch
        ProtocolPanel              matlab.ui.container.Panel
        State2Panel                matlab.ui.container.Panel
        UL2CheckBox                matlab.ui.control.CheckBox
        UR2CheckBox                matlab.ui.control.CheckBox
        LL2CheckBox                matlab.ui.control.CheckBox
        LR2CheckBox                matlab.ui.control.CheckBox
        DurationsEditField_2Label  matlab.ui.control.Label
        Duration2EditField         matlab.ui.control.NumericEditField
        DelaysEditField_2Label     matlab.ui.control.Label
        Delay2EditField            matlab.ui.control.NumericEditField
        ULLabel_2                  matlab.ui.control.Label
        LLLabel_2                  matlab.ui.control.Label
        URLabel_2                  matlab.ui.control.Label
        LRLabel_2                  matlab.ui.control.Label
        State1Panel                matlab.ui.container.Panel
        UL1CheckBox                matlab.ui.control.CheckBox
        UR1CheckBox                matlab.ui.control.CheckBox
        LL1CheckBox                matlab.ui.control.CheckBox
        LR1CheckBox                matlab.ui.control.CheckBox
        DurationsEditFieldLabel    matlab.ui.control.Label
        Duration1EditField         matlab.ui.control.NumericEditField
        DelaysEditFieldLabel       matlab.ui.control.Label
        Delay1EditField            matlab.ui.control.NumericEditField
        ULLabel                    matlab.ui.control.Label
        LLLabel                    matlab.ui.control.Label
        URLabel                    matlab.ui.control.Label
        LRLabel                    matlab.ui.control.Label
        StartButton_2              matlab.ui.control.Button
        ProtocolLampLabel          matlab.ui.control.Label
        ProtocolLamp               matlab.ui.control.Lamp
        RepetitionsEditFieldLabel  matlab.ui.control.Label
        RepetitionsEditField       matlab.ui.control.NumericEditField
        ConfigurationTab           matlab.ui.container.Tab
        CameraPanel                matlab.ui.container.Panel
        linkLabel                  matlab.ui.control.Label
        linkEditField              matlab.ui.control.EditField
        userLabel                  matlab.ui.control.Label
        userEditField              matlab.ui.control.EditField
        passwordLabel              matlab.ui.control.Label
        passwordEditField          matlab.ui.control.EditField
        UpdateButton               matlab.ui.control.Button
        ArenaPanel                 matlab.ui.container.Panel
        UpperLeftDropDownLabel     matlab.ui.control.Label
        UpperLeftDropDown          matlab.ui.control.DropDown
        LowerLeftDropDownLabel     matlab.ui.control.Label
        LowerLeftDropDown          matlab.ui.control.DropDown
        UpperRightDropDownLabel    matlab.ui.control.Label
        UpperRightDropDown         matlab.ui.control.DropDown
        LowerRightDropDownLabel    matlab.ui.control.Label
        LowerRightDropDown         matlab.ui.control.DropDown
        RedLEDDropDownLabel        matlab.ui.control.Label
        RedLEDDropDown             matlab.ui.control.DropDown
        InfraRedLEDDropDownLabel   matlab.ui.control.Label
        InfraRedLEDDropDown        matlab.ui.control.DropDown
        UpdateButton_2             matlab.ui.control.Button
        CameraPreviewPanel         matlab.ui.container.Panel
        StartButton                matlab.ui.control.Button
        StopButton                 matlab.ui.control.Button
        WebInterfaceButton         matlab.ui.control.Button
        LEDIntensitiesPanel        matlab.ui.container.Panel
        IRLabel                    matlab.ui.control.Label
        IRKnob                     matlab.ui.control.Knob
        RedLabel                   matlab.ui.control.Label
        RedKnob                    matlab.ui.control.Knob
        MonitorPanel               matlab.ui.container.Panel
        URLampLabel                matlab.ui.control.Label
        URLamp                     matlab.ui.control.Lamp
        ULLampLabel                matlab.ui.control.Label
        ULLamp                     matlab.ui.control.Lamp
        LLLampLabel                matlab.ui.control.Label
        LLLamp                     matlab.ui.control.Lamp
        LRLampLabel                matlab.ui.control.Label
        LRLamp                     matlab.ui.control.Lamp
    end


    properties (Access = private)
        a % Arduino
        % define colors
        GREEN_COLOR = [0.0 1.0 0.0];
        RED_COLOR = [1.0 0.0 0.0];
        GRAY_COLOR = [0.5 0.5 0.5];
        camera % camera for arena imaging
        link % link to ip cam
        user % username for ip cam
        password % password for ip cam
        % Ports Configuration
        UL
        UR
        LL
        LR
        IRLed
        RedLed
        %Model
        PanelOutPutChannel
        PanelSwitch
        LEDKnobOutPutChannel
        int
        KnobValues
        w
        CheckBoxStateA
        CheckBoxStateB
        Monitor
    end

    methods (Access = private)
    
        
        
        function UpdateCamera(app)
            app.link=app.linkEditField.Value;
            app.user=app.userEditField.Value;
            app.password=app.passwordEditField.Value;
            app.camera=ipcam(app.linkEditField.Value, app.userEditField.Value, app.passwordEditField.Value);
            %app.camera=ipcam(app.linkEditField.Value);
        end
        
        function UpdateArena(app)
            app.UL=app.UpperLeftDropDown.Value;
            app.UR=app.UpperRightDropDown.Value;
            app.LL=app.LowerLeftDropDown.Value;
            app.LR=app.LowerRightDropDown.Value;
            app.IRLed=app.InfraRedLEDDropDown.Value;
            app.RedLed=app.RedLEDDropDown.Value;
            app.PanelOutPutChannel={app.UL, app.UR, app.LL, app.LR};
            app.LEDKnobOutPutChannel={app.IRLed, app.RedLed};
        end
        
        function PanelSwitchValues(app)
            app.PanelSwitch{1}=app.UpperLeftSwitch.Value;
            app.PanelSwitch{2}=app.UpperRightSwitch.Value;
            app.PanelSwitch{3}=app.LowerLeftSwitch.Value;
            app.PanelSwitch{4}=app.LowerRightSwitch.Value;
        end
        
        function LEDKnobValues(app)
            app.KnobValues{1}=app.IRKnob.Value;
            app.KnobValues{2}=app.RedKnob.Value;
        end
                
        function CheckBoxStateAValues(app)
            app.CheckBoxStateA{1}=app.UL1CheckBox.Value;
            app.CheckBoxStateA{2}=app.UR1CheckBox.Value;
            app.CheckBoxStateA{3}=app.LL1CheckBox.Value;
            app.CheckBoxStateA{4}=app.LR1CheckBox.Value;
        end
        
        function CheckBoxStateBValues(app)
            app.CheckBoxStateB{1}=app.UL2CheckBox.Value;
            app.CheckBoxStateB{2}=app.UR2CheckBox.Value;
            app.CheckBoxStateB{3}=app.LL2CheckBox.Value;
            app.CheckBoxStateB{4}=app.LR2CheckBox.Value;
        end
        
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.ConnectionLamp.Color = app.RED_COLOR;
            % (Instrument Control Toolbox required)
            p = instrhwinfo('serial');
            app.PortDropDown.Items = p.AvailableSerialPorts;
            % Connect to camera
            app.link=app.linkEditField.Value;
            app.user=app.userEditField.Value;
            app.password=app.passwordEditField.Value;
            %app.camera=ipcam(app.linkEditField.Value, app.userEditField.Value, app.passwordEditField.Value);
            % Set up Aren Ports
            app.UL=app.UpperLeftDropDown.Value;
            app.UR=app.UpperRightDropDown.Value;
            app.LL=app.LowerLeftDropDown.Value;
            app.LR=app.LowerRightDropDown.Value;
            app.IRLed=app.InfraRedLEDDropDown.Value;
            app.RedLed=app.RedLEDDropDown.Value;
            %app.Model=app.ModelDropDown.Value;
            app.PanelOutPutChannel={app.UL, app.UR, app.LL, app.LR};
            app.PanelSwitch={'Off','Off','Off','Off'};
            app.LEDKnobOutPutChannel={app.IRLed, app.RedLed};
            app.KnobValues={0, 0};
            app.CheckBoxStateA={'false','false','false','false'};
            app.CheckBoxStateB={'false','false','false','false'};
            app.Monitor={app.GRAY_COLOR,app.GRAY_COLOR,app.GRAY_COLOR,app.GRAY_COLOR};
        end

        % Button pushed function: ConnectButton
        function ConnectButtonPushed(app, event)
             app.a = arduino(app.PortDropDown.Value,app.ModelDropDown.Value);
             app.ConnectionLamp.Color = app.GREEN_COLOR;
             writePWMVoltage(app.a,app.RedLed,app.RedKnob.Value/100*2.5);
             writePWMVoltage(app.a,app.IRLed,app.IRKnob.Value/100*2.5);
        end

        % Button pushed function: DisconnectButton
        function DisconnectButtonPushed(app, event)
            % on disconnect close serial port and change lamp color to red
            app.a=0;
            delete(instrfind);
            app.ConnectionLamp.Color = app.RED_COLOR;
        end

        % Button pushed function: RefreshButton
        function RefreshButtonPushed(app, event)
            % delete all serial port objets from MATLAB memory
            % (Instrument Control Toolbox required)
            delete(instrfind);
            % looking for available serial ports 
            % (Instrument Control Toolbox required)
            p = instrhwinfo('serial');
            app.PortDropDown.Items = p.AvailableSerialPorts;
        end

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
            preview(app.camera);
        end

        % Button pushed function: StopButton
        function StopButtonPushed(app, event)
            closePreview(app.camera);
        end

        % Button pushed function: UpdateButton
        function UpdateButtonPushed(app, event)
            UpdateCamera(app);
        end

        % Button pushed function: UpdateButton_2
        function UpdateButton_2Pushed(app, event)
            UpdateArena(app);
        end

        % Value changed function: LowerLeftSwitch, 
        % LowerRightSwitch, UpperLeftSwitch, UpperRightSwitch
        function PanelSwitchValueChanged(app, event)
            PanelSwitchValues(app);
            for i=1:4
                if isequal(app.PanelSwitch{i},'On')
                   writeDigitalPin(app.a,app.PanelOutPutChannel{i},1);
                   app.Monitor{i}=app.RED_COLOR;
                else
                   writeDigitalPin(app.a,app.PanelOutPutChannel{i},0);
                   app.Monitor{i}=app.GRAY_COLOR;
                end
                app.ULLamp.Color=app.Monitor{1};
                app.URLamp.Color=app.Monitor{2};
                app.LLLamp.Color=app.Monitor{3};
                app.LRLamp.Color=app.Monitor{4};
            end
            
        end

        % Value changed function: IRKnob, RedKnob
        function KnobValueChanged(app, event)
            LEDKnobValues(app);
            for i=1:2
                app.int=app.KnobValues{i}/100*2.5;
                writePWMVoltage(app.a, app.LEDKnobOutPutChannel{i},app.int);
            end
        end

        % Value changing function: IRKnob, RedKnob
        function KnobValueChanging(app, event)
            changingValue = event.Value;
            
        end

        % Button pushed function: WebInterfaceButton
        function WebInterfaceButtonPushed(app, event)
            web(erase(app.linkEditField.Value,'cam_pic_new.php?'), '-notoolbar', '-noaddressbox');
        end

        % Button pushed function: StartButton_2
        function StartButton_2Pushed(app, event)
            %app.w = waitforbuttonpress;
            app.ProtocolLamp.Color=app.RED_COLOR;
            CheckBoxStateAValues(app);
            CheckBoxStateBValues(app);            
            for i=1:app.RepetitionsEditField.Value
                pause(app.Delay1EditField.Value)
                for j=1:4
                    if isequal(app.CheckBoxStateA{j},true)
                        writeDigitalPin(app.a,app.PanelOutPutChannel{j},1);
                        app.Monitor{j}=app.RED_COLOR;
                    end
                    app.ULLamp.Color=app.Monitor{1};
                    app.URLamp.Color=app.Monitor{2};
                    app.LLLamp.Color=app.Monitor{3};
                    app.LRLamp.Color=app.Monitor{4};
                end
                pause(app.Duration1EditField.Value);
                for j=1:4
                    writeDigitalPin(app.a,app.PanelOutPutChannel{j},0);
                    app.Monitor{j}=app.GRAY_COLOR;
                end
                app.ULLamp.Color=app.Monitor{1};
                app.URLamp.Color=app.Monitor{2};
                app.LLLamp.Color=app.Monitor{3};
                app.LRLamp.Color=app.Monitor{4};
                pause(app.Delay2EditField.Value);
                for j=1:4
                    if isequal(app.CheckBoxStateB{j},true)
                        writeDigitalPin(app.a,app.PanelOutPutChannel{j},1);
                        app.Monitor{j}=app.RED_COLOR;
                    end
                    app.ULLamp.Color=app.Monitor{1};
                    app.URLamp.Color=app.Monitor{2};
                    app.LLLamp.Color=app.Monitor{3};
                    app.LRLamp.Color=app.Monitor{4};
                end                               
                pause(app.Duration2EditField.Value);
                for j=1:4
                    writeDigitalPin(app.a,app.PanelOutPutChannel{j},0);
                    app.Monitor{j}=app.GRAY_COLOR;
                end
                app.ULLamp.Color=app.Monitor{1};
                app.URLamp.Color=app.Monitor{2};
                app.LLLamp.Color=app.Monitor{3};
                app.LRLamp.Color=app.Monitor{4};
            end
            app.ProtocolLamp.Color=app.GRAY_COLOR;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1023 799];
            app.UIFigure.Name = 'UI Figure';

            % Create ConnectionPanel
            app.ConnectionPanel = uipanel(app.UIFigure);
            app.ConnectionPanel.Title = 'Connection';
            app.ConnectionPanel.Position = [738 491 260 288];

            % Create ConnectionLampLabel
            app.ConnectionLampLabel = uilabel(app.ConnectionPanel);
            app.ConnectionLampLabel.HorizontalAlignment = 'right';
            app.ConnectionLampLabel.VerticalAlignment = 'top';
            app.ConnectionLampLabel.Position = [150 244 67 15];
            app.ConnectionLampLabel.Text = 'Connection';

            % Create ConnectionLamp
            app.ConnectionLamp = uilamp(app.ConnectionPanel);
            app.ConnectionLamp.Position = [232 241 20 20];
            app.ConnectionLamp.Color = [1 0 0];

            % Create PortDropDownLabel
            app.PortDropDownLabel = uilabel(app.ConnectionPanel);
            app.PortDropDownLabel.HorizontalAlignment = 'right';
            app.PortDropDownLabel.VerticalAlignment = 'top';
            app.PortDropDownLabel.Position = [18 201 28 15];
            app.PortDropDownLabel.Text = 'Port';

            % Create PortDropDown
            app.PortDropDown = uidropdown(app.ConnectionPanel);
            app.PortDropDown.Position = [61 197 188 22];

            % Create DisconnectButton
            app.DisconnectButton = uibutton(app.ConnectionPanel, 'push');
            app.DisconnectButton.ButtonPushedFcn = createCallbackFcn(app, @DisconnectButtonPushed, true);
            app.DisconnectButton.Position = [149 48 100 22];
            app.DisconnectButton.Text = 'Disconnect';

            % Create ConnectButton
            app.ConnectButton = uibutton(app.ConnectionPanel, 'push');
            app.ConnectButton.ButtonPushedFcn = createCallbackFcn(app, @ConnectButtonPushed, true);
            app.ConnectButton.Position = [34 48 100 22];
            app.ConnectButton.Text = 'Connect';

            % Create RefreshButton
            app.RefreshButton = uibutton(app.ConnectionPanel, 'push');
            app.RefreshButton.ButtonPushedFcn = createCallbackFcn(app, @RefreshButtonPushed, true);
            app.RefreshButton.Position = [149 101 100 22];
            app.RefreshButton.Text = 'Refresh';

            % Create ModelDropDownLabel
            app.ModelDropDownLabel = uilabel(app.ConnectionPanel);
            app.ModelDropDownLabel.HorizontalAlignment = 'right';
            app.ModelDropDownLabel.VerticalAlignment = 'top';
            app.ModelDropDownLabel.Position = [18 158 39 15];
            app.ModelDropDownLabel.Text = 'Model';

            % Create ModelDropDown
            app.ModelDropDown = uidropdown(app.ConnectionPanel);
            app.ModelDropDown.Items = {'UNO', 'Mega2560'};
            app.ModelDropDown.Position = [72 154 177 22];
            app.ModelDropDown.Value = 'UNO';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [50 25 637 754];

            % Create ArenaControlTab
            app.ArenaControlTab = uitab(app.TabGroup);
            app.ArenaControlTab.Title = 'Arena Control';

            % Create ManualRedLEDPanels
            app.ManualRedLEDPanels = uipanel(app.ArenaControlTab);
            app.ManualRedLEDPanels.Title = 'Manual Red LED Panels';
            app.ManualRedLEDPanels.Position = [42 464 543 240];

            % Create UpperLeftSwitchLabel
            app.UpperLeftSwitchLabel = uilabel(app.ManualRedLEDPanels);
            app.UpperLeftSwitchLabel.HorizontalAlignment = 'center';
            app.UpperLeftSwitchLabel.VerticalAlignment = 'top';
            app.UpperLeftSwitchLabel.Position = [156 128 63 15];
            app.UpperLeftSwitchLabel.Text = 'Upper Left';

            % Create UpperLeftSwitch
            app.UpperLeftSwitch = uiswitch(app.ManualRedLEDPanels, 'slider');
            app.UpperLeftSwitch.ValueChangedFcn = createCallbackFcn(app, @PanelSwitchValueChanged, true);
            app.UpperLeftSwitch.Position = [165 158 45 20];

            % Create UpperRightSwitchLabel
            app.UpperRightSwitchLabel = uilabel(app.ManualRedLEDPanels);
            app.UpperRightSwitchLabel.HorizontalAlignment = 'center';
            app.UpperRightSwitchLabel.VerticalAlignment = 'top';
            app.UpperRightSwitchLabel.Position = [275 128 70 15];
            app.UpperRightSwitchLabel.Text = 'Upper Right';

            % Create UpperRightSwitch
            app.UpperRightSwitch = uiswitch(app.ManualRedLEDPanels, 'slider');
            app.UpperRightSwitch.ValueChangedFcn = createCallbackFcn(app, @PanelSwitchValueChanged, true);
            app.UpperRightSwitch.Position = [287 158 45 20];

            % Create LowerLeftSwitchLabel
            app.LowerLeftSwitchLabel = uilabel(app.ManualRedLEDPanels);
            app.LowerLeftSwitchLabel.HorizontalAlignment = 'center';
            app.LowerLeftSwitchLabel.VerticalAlignment = 'top';
            app.LowerLeftSwitchLabel.Position = [157 48 62 15];
            app.LowerLeftSwitchLabel.Text = 'Lower Left';

            % Create LowerLeftSwitch
            app.LowerLeftSwitch = uiswitch(app.ManualRedLEDPanels, 'slider');
            app.LowerLeftSwitch.ValueChangedFcn = createCallbackFcn(app, @PanelSwitchValueChanged, true);
            app.LowerLeftSwitch.Position = [165 78 45 20];

            % Create LowerRightSwitchLabel
            app.LowerRightSwitchLabel = uilabel(app.ManualRedLEDPanels);
            app.LowerRightSwitchLabel.HorizontalAlignment = 'center';
            app.LowerRightSwitchLabel.VerticalAlignment = 'top';
            app.LowerRightSwitchLabel.Position = [275 48 70 15];
            app.LowerRightSwitchLabel.Text = 'Lower Right';

            % Create LowerRightSwitch
            app.LowerRightSwitch = uiswitch(app.ManualRedLEDPanels, 'slider');
            app.LowerRightSwitch.ValueChangedFcn = createCallbackFcn(app, @PanelSwitchValueChanged, true);
            app.LowerRightSwitch.Position = [287 78 45 20];

            % Create ProtocolPanel
            app.ProtocolPanel = uipanel(app.ArenaControlTab);
            app.ProtocolPanel.Title = 'Protocol';
            app.ProtocolPanel.Position = [42 121 543 330];

            % Create State2Panel
            app.State2Panel = uipanel(app.ProtocolPanel);
            app.State2Panel.Title = 'State 2';
            app.State2Panel.Position = [257 66 260 221];

            % Create UL2CheckBox
            app.UL2CheckBox = uicheckbox(app.State2Panel);
            app.UL2CheckBox.Text = '';
            app.UL2CheckBox.Position = [106 109 21 15];

            % Create UR2CheckBox
            app.UR2CheckBox = uicheckbox(app.State2Panel);
            app.UR2CheckBox.Text = '';
            app.UR2CheckBox.Position = [140 109 88 15];
            app.UR2CheckBox.Value = true;

            % Create LL2CheckBox
            app.LL2CheckBox = uicheckbox(app.State2Panel);
            app.LL2CheckBox.Text = '';
            app.LL2CheckBox.Position = [107 88 21 15];
            app.LL2CheckBox.Value = true;

            % Create LR2CheckBox
            app.LR2CheckBox = uicheckbox(app.State2Panel);
            app.LR2CheckBox.Text = '';
            app.LR2CheckBox.Position = [140 88 24 15];

            % Create DurationsEditField_2Label
            app.DurationsEditField_2Label = uilabel(app.State2Panel);
            app.DurationsEditField_2Label.HorizontalAlignment = 'right';
            app.DurationsEditField_2Label.VerticalAlignment = 'top';
            app.DurationsEditField_2Label.Position = [25 53 67 15];
            app.DurationsEditField_2Label.Text = 'Duration [s]';

            % Create Duration2EditField
            app.Duration2EditField = uieditfield(app.State2Panel, 'numeric');
            app.Duration2EditField.Position = [173 49 34 22];
            app.Duration2EditField.Value = 30;

            % Create DelaysEditField_2Label
            app.DelaysEditField_2Label = uilabel(app.State2Panel);
            app.DelaysEditField_2Label.HorizontalAlignment = 'right';
            app.DelaysEditField_2Label.VerticalAlignment = 'top';
            app.DelaysEditField_2Label.Position = [41 152 51 15];
            app.DelaysEditField_2Label.Text = 'Delay [s]';

            % Create Delay2EditField
            app.Delay2EditField = uieditfield(app.State2Panel, 'numeric');
            app.Delay2EditField.Position = [173 148 34 22];
            app.Delay2EditField.Value = 30;

            % Create ULLabel_2
            app.ULLabel_2 = uilabel(app.State2Panel);
            app.ULLabel_2.VerticalAlignment = 'top';
            app.ULLabel_2.Position = [73 109 25 15];
            app.ULLabel_2.Text = 'UL';

            % Create LLLabel_2
            app.LLLabel_2 = uilabel(app.State2Panel);
            app.LLLabel_2.VerticalAlignment = 'top';
            app.LLLabel_2.Position = [73 88 25 15];
            app.LLLabel_2.Text = 'LL';

            % Create URLabel_2
            app.URLabel_2 = uilabel(app.State2Panel);
            app.URLabel_2.VerticalAlignment = 'top';
            app.URLabel_2.Position = [165 109 25 15];
            app.URLabel_2.Text = 'UR';

            % Create LRLabel_2
            app.LRLabel_2 = uilabel(app.State2Panel);
            app.LRLabel_2.VerticalAlignment = 'top';
            app.LRLabel_2.Position = [165 88 25 15];
            app.LRLabel_2.Text = 'LR';

            % Create State1Panel
            app.State1Panel = uipanel(app.ProtocolPanel);
            app.State1Panel.Title = 'State 1';
            app.State1Panel.Position = [20 66 228 221];

            % Create UL1CheckBox
            app.UL1CheckBox = uicheckbox(app.State1Panel);
            app.UL1CheckBox.Text = '';
            app.UL1CheckBox.Position = [108 109 16 15];
            app.UL1CheckBox.Value = true;

            % Create UR1CheckBox
            app.UR1CheckBox = uicheckbox(app.State1Panel);
            app.UR1CheckBox.Text = '';
            app.UR1CheckBox.Position = [131 109 16 15];

            % Create LL1CheckBox
            app.LL1CheckBox = uicheckbox(app.State1Panel);
            app.LL1CheckBox.Text = '';
            app.LL1CheckBox.Position = [108 88 16 15];

            % Create LR1CheckBox
            app.LR1CheckBox = uicheckbox(app.State1Panel);
            app.LR1CheckBox.Text = '';
            app.LR1CheckBox.Position = [131 88 14 15];
            app.LR1CheckBox.Value = true;

            % Create DurationsEditFieldLabel
            app.DurationsEditFieldLabel = uilabel(app.State1Panel);
            app.DurationsEditFieldLabel.HorizontalAlignment = 'right';
            app.DurationsEditFieldLabel.VerticalAlignment = 'top';
            app.DurationsEditFieldLabel.Position = [47 53 67 15];
            app.DurationsEditFieldLabel.Text = 'Duration [s]';

            % Create Duration1EditField
            app.Duration1EditField = uieditfield(app.State1Panel, 'numeric');
            app.Duration1EditField.Position = [129 49 32 22];
            app.Duration1EditField.Value = 30;

            % Create DelaysEditFieldLabel
            app.DelaysEditFieldLabel = uilabel(app.State1Panel);
            app.DelaysEditFieldLabel.HorizontalAlignment = 'right';
            app.DelaysEditFieldLabel.VerticalAlignment = 'top';
            app.DelaysEditFieldLabel.Position = [47 152 51 15];
            app.DelaysEditFieldLabel.Text = 'Delay [s]';

            % Create Delay1EditField
            app.Delay1EditField = uieditfield(app.State1Panel, 'numeric');
            app.Delay1EditField.Position = [128 148 33 22];
            app.Delay1EditField.Value = 30;

            % Create ULLabel
            app.ULLabel = uilabel(app.State1Panel);
            app.ULLabel.VerticalAlignment = 'top';
            app.ULLabel.Position = [73 109 25 15];
            app.ULLabel.Text = 'UL';

            % Create LLLabel
            app.LLLabel = uilabel(app.State1Panel);
            app.LLLabel.VerticalAlignment = 'top';
            app.LLLabel.Position = [73 88 25 15];
            app.LLLabel.Text = 'LL';

            % Create URLabel
            app.URLabel = uilabel(app.State1Panel);
            app.URLabel.VerticalAlignment = 'top';
            app.URLabel.Position = [160 109 25 15];
            app.URLabel.Text = 'UR';

            % Create LRLabel
            app.LRLabel = uilabel(app.State1Panel);
            app.LRLabel.VerticalAlignment = 'top';
            app.LRLabel.Position = [160 88 25 15];
            app.LRLabel.Text = 'LR';

            % Create StartButton_2
            app.StartButton_2 = uibutton(app.ProtocolPanel, 'push');
            app.StartButton_2.ButtonPushedFcn = createCallbackFcn(app, @StartButton_2Pushed, true);
            app.StartButton_2.Position = [417 26 100 22];
            app.StartButton_2.Text = 'Start';

            % Create ProtocolLampLabel
            app.ProtocolLampLabel = uilabel(app.ProtocolPanel);
            app.ProtocolLampLabel.HorizontalAlignment = 'right';
            app.ProtocolLampLabel.VerticalAlignment = 'top';
            app.ProtocolLampLabel.Position = [298 30 51 15];
            app.ProtocolLampLabel.Text = 'Protocol';

            % Create ProtocolLamp
            app.ProtocolLamp = uilamp(app.ProtocolPanel);
            app.ProtocolLamp.Position = [364 27 20 20];
            app.ProtocolLamp.Color = [0.502 0.502 0.502];

            % Create RepetitionsEditFieldLabel
            app.RepetitionsEditFieldLabel = uilabel(app.ProtocolPanel);
            app.RepetitionsEditFieldLabel.HorizontalAlignment = 'right';
            app.RepetitionsEditFieldLabel.VerticalAlignment = 'top';
            app.RepetitionsEditFieldLabel.Position = [67 30 66 15];
            app.RepetitionsEditFieldLabel.Text = 'Repetitions';

            % Create RepetitionsEditField
            app.RepetitionsEditField = uieditfield(app.ProtocolPanel, 'numeric');
            app.RepetitionsEditField.Position = [148 26 100 22];
            app.RepetitionsEditField.Value = 1;

            % Create ConfigurationTab
            app.ConfigurationTab = uitab(app.TabGroup);
            app.ConfigurationTab.Title = 'Configuration';

            % Create CameraPanel
            app.CameraPanel = uipanel(app.ConfigurationTab);
            app.CameraPanel.Title = 'Camera';
            app.CameraPanel.Position = [46 483 552 221];

            % Create linkLabel
            app.linkLabel = uilabel(app.CameraPanel);
            app.linkLabel.HorizontalAlignment = 'right';
            app.linkLabel.VerticalAlignment = 'top';
            app.linkLabel.Position = [69 156 27 15];
            app.linkLabel.Text = 'link:';

            % Create linkEditField
            app.linkEditField = uieditfield(app.CameraPanel, 'text');
            app.linkEditField.Position = [111 152 273 22];
            app.linkEditField.Value = 'http://131.246.185.251/html/cam_pic_new.php?';

            % Create userLabel
            app.userLabel = uilabel(app.CameraPanel);
            app.userLabel.HorizontalAlignment = 'right';
            app.userLabel.VerticalAlignment = 'top';
            app.userLabel.Position = [64 118 32 15];
            app.userLabel.Text = 'user:';

            % Create userEditField
            app.userEditField = uieditfield(app.CameraPanel, 'text');
            app.userEditField.Position = [111 114 100 22];
            app.userEditField.Value = 'ben';

            % Create passwordLabel
            app.passwordLabel = uilabel(app.CameraPanel);
            app.passwordLabel.HorizontalAlignment = 'right';
            app.passwordLabel.VerticalAlignment = 'top';
            app.passwordLabel.Position = [33 78 61 15];
            app.passwordLabel.Text = 'password:';

            % Create passwordEditField
            app.passwordEditField = uieditfield(app.CameraPanel, 'text');
            app.passwordEditField.Position = [109 74 100 22];
            app.passwordEditField.Value = 'ben';

            % Create UpdateButton
            app.UpdateButton = uibutton(app.CameraPanel, 'push');
            app.UpdateButton.ButtonPushedFcn = createCallbackFcn(app, @UpdateButtonPushed, true);
            app.UpdateButton.Position = [432 15 100 22];
            app.UpdateButton.Text = 'Update';

            % Create ArenaPanel
            app.ArenaPanel = uipanel(app.ConfigurationTab);
            app.ArenaPanel.Title = 'Arena';
            app.ArenaPanel.Position = [46 64 552 396];

            % Create UpperLeftDropDownLabel
            app.UpperLeftDropDownLabel = uilabel(app.ArenaPanel);
            app.UpperLeftDropDownLabel.HorizontalAlignment = 'right';
            app.UpperLeftDropDownLabel.VerticalAlignment = 'top';
            app.UpperLeftDropDownLabel.Position = [64 322 63 15];
            app.UpperLeftDropDownLabel.Text = 'Upper Left';

            % Create UpperLeftDropDown
            app.UpperLeftDropDown = uidropdown(app.ArenaPanel);
            app.UpperLeftDropDown.Items = {'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10', 'D11', 'D12', 'D13'};
            app.UpperLeftDropDown.Position = [142 318 100 22];
            app.UpperLeftDropDown.Value = 'D2';

            % Create LowerLeftDropDownLabel
            app.LowerLeftDropDownLabel = uilabel(app.ArenaPanel);
            app.LowerLeftDropDownLabel.HorizontalAlignment = 'right';
            app.LowerLeftDropDownLabel.VerticalAlignment = 'top';
            app.LowerLeftDropDownLabel.Position = [65 277 62 15];
            app.LowerLeftDropDownLabel.Text = 'Lower Left';

            % Create LowerLeftDropDown
            app.LowerLeftDropDown = uidropdown(app.ArenaPanel);
            app.LowerLeftDropDown.Items = {'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10', 'D11', 'D12', 'D13'};
            app.LowerLeftDropDown.Position = [142 273 100 22];
            app.LowerLeftDropDown.Value = 'D4';

            % Create UpperRightDropDownLabel
            app.UpperRightDropDownLabel = uilabel(app.ArenaPanel);
            app.UpperRightDropDownLabel.HorizontalAlignment = 'right';
            app.UpperRightDropDownLabel.VerticalAlignment = 'top';
            app.UpperRightDropDownLabel.Position = [383 322 70 15];
            app.UpperRightDropDownLabel.Text = 'Upper Right';

            % Create UpperRightDropDown
            app.UpperRightDropDown = uidropdown(app.ArenaPanel);
            app.UpperRightDropDown.Items = {'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10', 'D11', 'D12', 'D13'};
            app.UpperRightDropDown.Position = [263 318 100 22];
            app.UpperRightDropDown.Value = 'D3';

            % Create LowerRightDropDownLabel
            app.LowerRightDropDownLabel = uilabel(app.ArenaPanel);
            app.LowerRightDropDownLabel.HorizontalAlignment = 'right';
            app.LowerRightDropDownLabel.VerticalAlignment = 'top';
            app.LowerRightDropDownLabel.Position = [386 277 70 15];
            app.LowerRightDropDownLabel.Text = 'Lower Right';

            % Create LowerRightDropDown
            app.LowerRightDropDown = uidropdown(app.ArenaPanel);
            app.LowerRightDropDown.Items = {'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10', 'D11', 'D12', 'D13'};
            app.LowerRightDropDown.Position = [263 273 100 22];
            app.LowerRightDropDown.Value = 'D5';

            % Create RedLEDDropDownLabel
            app.RedLEDDropDownLabel = uilabel(app.ArenaPanel);
            app.RedLEDDropDownLabel.HorizontalAlignment = 'right';
            app.RedLEDDropDownLabel.VerticalAlignment = 'top';
            app.RedLEDDropDownLabel.Position = [74 179 53 15];
            app.RedLEDDropDownLabel.Text = 'Red LED';

            % Create RedLEDDropDown
            app.RedLEDDropDown = uidropdown(app.ArenaPanel);
            app.RedLEDDropDown.Items = {'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10', 'D11', 'D12', 'D13'};
            app.RedLEDDropDown.Position = [142 175 100 22];
            app.RedLEDDropDown.Value = 'D11';

            % Create InfraRedLEDDropDownLabel
            app.InfraRedLEDDropDownLabel = uilabel(app.ArenaPanel);
            app.InfraRedLEDDropDownLabel.HorizontalAlignment = 'right';
            app.InfraRedLEDDropDownLabel.VerticalAlignment = 'top';
            app.InfraRedLEDDropDownLabel.Position = [47 142 80 15];
            app.InfraRedLEDDropDownLabel.Text = 'Infra Red LED';

            % Create InfraRedLEDDropDown
            app.InfraRedLEDDropDown = uidropdown(app.ArenaPanel);
            app.InfraRedLEDDropDown.Items = {'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10', 'D11', 'D12', 'D13'};
            app.InfraRedLEDDropDown.Position = [142 138 100 22];
            app.InfraRedLEDDropDown.Value = 'D10';

            % Create UpdateButton_2
            app.UpdateButton_2 = uibutton(app.ArenaPanel, 'push');
            app.UpdateButton_2.ButtonPushedFcn = createCallbackFcn(app, @UpdateButton_2Pushed, true);
            app.UpdateButton_2.Position = [432 23 100 22];
            app.UpdateButton_2.Text = 'Update';

            % Create CameraPreviewPanel
            app.CameraPreviewPanel = uipanel(app.UIFigure);
            app.CameraPreviewPanel.Title = 'Camera Preview';
            app.CameraPreviewPanel.Position = [738 375 260 101];

            % Create StartButton
            app.StartButton = uibutton(app.CameraPreviewPanel, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.Position = [18 36 100 22];
            app.StartButton.Text = 'Start';

            % Create StopButton
            app.StopButton = uibutton(app.CameraPreviewPanel, 'push');
            app.StopButton.ButtonPushedFcn = createCallbackFcn(app, @StopButtonPushed, true);
            app.StopButton.Position = [134 36 100 22];
            app.StopButton.Text = 'Stop';

            % Create WebInterfaceButton
            app.WebInterfaceButton = uibutton(app.CameraPreviewPanel, 'push');
            app.WebInterfaceButton.ButtonPushedFcn = createCallbackFcn(app, @WebInterfaceButtonPushed, true);
            app.WebInterfaceButton.Position = [80 6 100 22];
            app.WebInterfaceButton.Text = 'Web Interface';

            % Create LEDIntensitiesPanel
            app.LEDIntensitiesPanel = uipanel(app.UIFigure);
            app.LEDIntensitiesPanel.Title = 'LED Intensities';
            app.LEDIntensitiesPanel.Position = [738 146 260 221];

            % Create IRLabel
            app.IRLabel = uilabel(app.LEDIntensitiesPanel);
            app.IRLabel.HorizontalAlignment = 'center';
            app.IRLabel.VerticalAlignment = 'top';
            app.IRLabel.Position = [50 35 38 15];
            app.IRLabel.Text = 'IR [%]';

            % Create IRKnob
            app.IRKnob = uiknob(app.LEDIntensitiesPanel, 'continuous');
            app.IRKnob.ValueChangedFcn = createCallbackFcn(app, @KnobValueChanged, true);
            app.IRKnob.ValueChangingFcn = createCallbackFcn(app, @KnobValueChanging, true);
            app.IRKnob.Position = [38 84 60 60];
            app.IRKnob.Value = 1;

            % Create RedLabel
            app.RedLabel = uilabel(app.LEDIntensitiesPanel);
            app.RedLabel.HorizontalAlignment = 'center';
            app.RedLabel.VerticalAlignment = 'top';
            app.RedLabel.Position = [164 33 52 15];
            app.RedLabel.Text = 'Red  [%]';

            % Create RedKnob
            app.RedKnob = uiknob(app.LEDIntensitiesPanel, 'continuous');
            app.RedKnob.ValueChangedFcn = createCallbackFcn(app, @KnobValueChanged, true);
            app.RedKnob.ValueChangingFcn = createCallbackFcn(app, @KnobValueChanging, true);
            app.RedKnob.Position = [160 82 60 60];
            app.RedKnob.Value = 83;

            % Create MonitorPanel
            app.MonitorPanel = uipanel(app.UIFigure);
            app.MonitorPanel.Title = 'Monitor';
            app.MonitorPanel.Position = [738 25 260 112];

            % Create URLampLabel
            app.URLampLabel = uilabel(app.MonitorPanel);
            app.URLampLabel.HorizontalAlignment = 'right';
            app.URLampLabel.VerticalAlignment = 'top';
            app.URLampLabel.Position = [137 58 25 15];
            app.URLampLabel.Text = 'UR';

            % Create URLamp
            app.URLamp = uilamp(app.MonitorPanel);
            app.URLamp.Position = [177 55 20 20];
            app.URLamp.Color = [0.502 0.502 0.502];

            % Create ULLampLabel
            app.ULLampLabel = uilabel(app.MonitorPanel);
            app.ULLampLabel.HorizontalAlignment = 'right';
            app.ULLampLabel.VerticalAlignment = 'top';
            app.ULLampLabel.Position = [49 58 25 15];
            app.ULLampLabel.Text = 'UL';

            % Create ULLamp
            app.ULLamp = uilamp(app.MonitorPanel);
            app.ULLamp.Position = [89 55 20 20];
            app.ULLamp.Color = [0.502 0.502 0.502];

            % Create LLLampLabel
            app.LLLampLabel = uilabel(app.MonitorPanel);
            app.LLLampLabel.HorizontalAlignment = 'right';
            app.LLLampLabel.VerticalAlignment = 'top';
            app.LLLampLabel.Position = [49 21 25 15];
            app.LLLampLabel.Text = 'LL';

            % Create LLLamp
            app.LLLamp = uilamp(app.MonitorPanel);
            app.LLLamp.Position = [89 18 20 20];
            app.LLLamp.Color = [0.502 0.502 0.502];

            % Create LRLampLabel
            app.LRLampLabel = uilabel(app.MonitorPanel);
            app.LRLampLabel.HorizontalAlignment = 'right';
            app.LRLampLabel.VerticalAlignment = 'top';
            app.LRLampLabel.Position = [137 21 25 15];
            app.LRLampLabel.Text = 'LR';

            % Create LRLamp
            app.LRLamp = uilamp(app.MonitorPanel);
            app.LRLamp.Position = [177 18 20 20];
            app.LRLamp.Color = [0.502 0.502 0.502];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Arena_GUI_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end